public class ContactCountBatchApex implements Database.Batchable<sObject>, Database.Stateful {

    public Integer totalUpdated = 0;
    public Integer totalFailed = 0;

    // STEP 1: Start
    public Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator('SELECT Id FROM Account');
    }

    // STEP 2: Execute
    public void execute(Database.BatchableContext bc, List<Account> scope) {

        Set<Id> accountIds = new Set<Id>();
        for (Account acc : scope) {
            accountIds.add(acc.Id);
        }

        Map<Id, Integer> accountCountMap = new Map<Id, Integer>();

        for (AggregateResult ar : [
            SELECT AccountId accId, COUNT(Id) totalCount
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ]) {
            accountCountMap.put((Id) ar.get('accId'), (Integer) ar.get('totalCount'));
        }

        List<Account> updateAccounts = new List<Account>();

        for (Id accId : accountIds) {
            Integer contactCount = accountCountMap.containsKey(accId)
                ? accountCountMap.get(accId)
                : 0;

            String contactStatus = contactCount > 0 ? 'Has Contacts' : 'No Contacts';

            updateAccounts.add(new Account(
                Id = accId,
                Total_Contacts__c = contactCount,
                Contact_Status__c = contactStatus
            ));
        }

        if (!updateAccounts.isEmpty()) {
            Database.SaveResult[] results = Database.update(updateAccounts, false);

            for (Database.SaveResult sr : results) {
                if (sr.isSuccess()) {
                    totalUpdated++;
                } else {
                    totalFailed++;
                    for (Database.Error err : sr.getErrors()) {
                        System.debug('Update failed: ' + err.getMessage());
                    }
                }
            }
        }
    }

    // STEP 3: Finish
    public void finish(Database.BatchableContext bc) {
        System.debug('Batch Completed');
        System.debug('Updated: ' + totalUpdated);
        System.debug('Failed: ' + totalFailed);
    }
}