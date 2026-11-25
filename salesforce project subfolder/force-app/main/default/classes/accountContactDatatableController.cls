public with sharing class accountContactDatatableController {
    
    @AuraEnabled(cacheable=true)
      
    public static List<Contact> getContacts(Id accountId) {

        return [SELECT Id,Name,Email,Phone FROM Contact  WHERE AccountId =:accountId];

    }
    @AuraEnabled

    public static void deleteContacts(List<Id> contactIds){
      
        if(contactIds ==null ||contactIds.isEmpty()){
            return;
        }
        List<Contact> contactsToDelete =[SELECT Id FROM Contact WHERE Id IN:contactIds];

                delete contactsToDelete;

    }
}