public with sharing class AccountHandler {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountDetails(Id accId){
        try {

            return [SELECT Name,Phone,Industry,Rating FROM Account WHERE Id=:accId];
            
        } catch (Exception e) 
        
        {
            throw new AuraHandledException(e.getMessage());
        }
    }
}