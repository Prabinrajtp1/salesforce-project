public with sharing class agentforceGetContactInfo 

{
    public class ContactInput {
        @InvocableVariable(required=true label='Contact Email')
        public String email;

    }
    public class ContactOutput {
        @InvocableVariable(label='Contact Name')
        public String name;
        @InvocableVariable(label='Contact Phone')
        public String phone;
        @InvocableVariable(label='Account Name')
        public String accountName;
        @InvocableVariable(label='Contact Email')
        public String email;
    }

    @InvocableMethod(label='Get Contact Info' description='Fetches Contact and related Account info by Contact Email')
    public static List<ContactOutput> getContactInfo(List<ContactInput> Inputs) {
        List<ContactOutput> results = new List<ContactOutput>();
        for (ContactInput con : Inputs)
        {
            ContactOutput out = new ContactOutput();
            Contact c = [SELECT Name, Email, Phone, Account.Name FROM Contact WHERE Email = :con.email LIMIT 1];
           
            out.email = c.Email;
            out.accountName = c.Account?.Name;
            out.name = c.Name;
            out.phone = c.Phone;
            results.add(out);

        }

        return results;
}
}