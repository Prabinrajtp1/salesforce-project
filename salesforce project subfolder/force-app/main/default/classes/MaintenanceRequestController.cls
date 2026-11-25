public with sharing class MaintenanceRequestController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getOpenRequests(
        Id accountId
    ) {
        return [
            SELECT Id,
                   Name,
                   Email,
                   Phone
            FROM Contact
            WHERE AccountId = :accountId
        ];
    }
}