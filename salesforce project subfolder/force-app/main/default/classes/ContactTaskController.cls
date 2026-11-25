public with sharing class ContactTaskController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getRelatedTaskDetails() {

        try {

            List<Contact> contacts = [
                SELECT Id, Name, Phone, Email,
                    (SELECT Id, Subject, Status, ActivityDate,
                            Owner.Name
                     FROM Tasks
                     ORDER BY ActivityDate DESC)
                FROM Contact
                WHERE Owner.IsActive = true
            ];

            List<Contact> contactsWithTasks = new List<Contact>();

            for (Contact con : contacts) {

                if (!con.Tasks.isEmpty()) {
                    contactsWithTasks.add(con);
                }
            }

            return contactsWithTasks;

        } catch (Exception e) {

            throw new AuraHandledException(e.getMessage());
        }
        
    }
}