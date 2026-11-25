public with sharing class AccountContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(Id accountId) {
     return[SELECT Id,AccountId,Name,Phone,Email FROM Contact WHERE AccountId=:accountId ];
    }
}