public with sharing class accountDatatable {

    @AuraEnabled(cacheable=true)
    public static List<Account> getAccounts(){
        try {

            return [SELECT Id,Name,Industry,Phone,Website FROM Account];
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    
}