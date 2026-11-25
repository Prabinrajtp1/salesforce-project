//Write a trigger that sets a checkbox to true when all related Cases are closed.


trigger CaseUpdationtrigger on Case (
    after insert, after update, after delete, after undelete
) {

    Set<Id> accountIds = new Set<Id>();

    // Collect Account IDs from Trigger.new
    if (Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete) {

        for (Case ca : Trigger.new) {
            if (ca.AccountId != null) {
                accountIds.add(ca.AccountId);
            }
        }
    }

    // Collect Account IDs from Trigger.old
    if (Trigger.isUpdate || Trigger.isDelete) {

        for (Case ca : Trigger.old) {
            if (ca.AccountId != null) {
                accountIds.add(ca.AccountId);
            }
        }
    }

    if (accountIds.isEmpty()) {
        return;
    }

    // Store total and closed Case counts
    Map<Id, Integer> totalCaseCountMap = new Map<Id, Integer>();
    Map<Id, Integer> closedCaseCountMap = new Map<Id, Integer>();

    // Aggregate SOQL Query
    for (AggregateResult ar : [
        SELECT AccountId, IsClosed, COUNT(Id) totalCount
        FROM Case
        WHERE AccountId IN :accountIds
        GROUP BY AccountId, IsClosed
    ]) {

        Id accId = (Id) ar.get('AccountId');
        Boolean isClosed = (Boolean) ar.get('IsClosed');
        Integer countCases = (Integer) ar.get('totalCount');

        // Calculate total Case count
        Integer existingTotal = totalCaseCountMap.containsKey(accId)
            ? totalCaseCountMap.get(accId) : 0;

        totalCaseCountMap.put(accId, existingTotal + countCases);

        // Calculate closed Case count
        if (isClosed) {
            closedCaseCountMap.put(accId, countCases);
        }
    }

    // Prepare Account records for update
    List<Account> updateAccounts = new List<Account>();

    for (Id accId : accountIds) {

        Integer total = totalCaseCountMap.containsKey(accId)
            ? totalCaseCountMap.get(accId) : 0;

        Integer totalClosed = closedCaseCountMap.containsKey(accId)
            ? closedCaseCountMap.get(accId) : 0;

        updateAccounts.add(new Account(
            Id = accId,
            All_Cases_Closed__c = (total > 0 && total == totalClosed)
        ));
    }

    // Update Accounts
    if (!updateAccounts.isEmpty()) {
        update updateAccounts;
    }
}