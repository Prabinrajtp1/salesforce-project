public class ContactTriggerHandlerSwitch {

    public static void getActiveContactCount(
        List<Contact> newList,
        List<Contact> oldList,
        Map<Id, Contact> oldMap,
        System.TriggerOperation operation
    ) {
        Set<Id> accountIds = new Set<Id>();

        switch on operation {

            when AFTER_INSERT, AFTER_UNDELETE {
                for (Contact con : newList) {
                    if (con.AccountId != null) {
                        accountIds.add(con.AccountId);
                    }
                }
            }

            when AFTER_UPDATE {
                for (Contact con : newList) {
                    Contact oldCon = oldMap.get(con.Id);

                    if (con.AccountId != oldCon.AccountId || con.Active__c != oldCon.Active__c) {
                        if (con.AccountId != null) {
                            accountIds.add(con.AccountId);
                        }
                        if (oldCon.AccountId != null) {
                            accountIds.add(oldCon.AccountId);
                        }
                    }
                }
            }

            when AFTER_DELETE {
                for (Contact con : oldList) {
                    if (con.AccountId != null) {
                        accountIds.add(con.AccountId);
                    }
                }
            }

            when else {
                return;
            }
        }

        if (accountIds.isEmpty()) {
            return;
        }

        // Default every affected account to 0 so accounts with no active contacts get reset
        Map<Id, Integer> countMap = new Map<Id, Integer>();
        for (Id accId : accountIds) {
            countMap.put(accId, 0);
        }

        for (AggregateResult ar : [
            SELECT AccountId accId, COUNT(Id) totalCount
            FROM Contact
            WHERE AccountId IN :accountIds AND Active__c = true
            GROUP BY AccountId
        ]) {
            countMap.put((Id) ar.get('accId'), (Integer) ar.get('totalCount'));
        }

        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : countMap.keySet()) {
            accountsToUpdate.add(new Account(Id = accId, Active_Contacts__c = countMap.get(accId)));
        }

        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}