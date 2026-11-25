public with sharing class AccountContactHandler {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactDetails(Id accountId) {
        return [
            SELECT Id, Name, Email, Phone, Title
            FROM Contact
            WHERE AccountId = :accountId
        ];
    }
}