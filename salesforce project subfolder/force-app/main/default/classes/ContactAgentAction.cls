public class ContactAgentAction {

    public class Input {
        @InvocableVariable(required=true)
        public String contactName;
    }

    public class Output {
        @InvocableVariable
        public String contactDetails;
        @InvocableVariable
        public String accountDetails;
        @InvocableVariable
        public String message;
    }

    @InvocableMethod(label='Get Contact With Account Details')
    public static List<Output> getContactDetails(List<Input> requests) {

        List<Output> results = new List<Output>();

        for (Input request : requests) {

            Output response = new Output();

            List<Contact> contacts = [
                SELECT
                    Name,
                    Email,
                    Phone,
                    Title,
                    Department,
                    Account.Name,
                    Account.Industry,
                    Account.Phone,
                    Account.Website,
                    Account.AnnualRevenue
                FROM Contact
                WHERE Name LIKE :('%' + request.contactName + '%')
                LIMIT 1
            ];

            if (!contacts.isEmpty()) {

                Contact c = contacts[0];

                response.contactDetails =
                    'Name: ' + c.Name +
                    '\nEmail: ' + c.Email +
                    '\nPhone: ' + c.Phone +
                    '\nTitle: ' + c.Title +
                    '\nDepartment: ' + c.Department;

                if (c.Account != null) {
                    response.accountDetails =
                        'Account Name: ' + c.Account.Name +
                        '\nIndustry: ' + c.Account.Industry +
                        '\nPhone: ' + c.Account.Phone +
                        '\nWebsite: ' + c.Account.Website +
                        '\nAnnual Revenue: ' + c.Account.AnnualRevenue;
                } else {
                    response.accountDetails = 'No Account associated with this Contact.';
                }

                response.message = 'Contact found successfully.';

            } else {
                response.message = 'No contact found.';
                response.contactDetails = '';
                response.accountDetails = '';
            }

            results.add(response);
        }

        return results;
    }
}