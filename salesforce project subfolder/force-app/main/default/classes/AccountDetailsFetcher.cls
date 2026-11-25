public class AccountDetailsFetcher {

    // Input wrapper - what Flow passes IN to Apex
    public class RequestWrapper {
        @InvocableVariable(required=true label='Account Id')
        public String accountId;
    }

    // Output wrapper - what Apex returns TO Flow
    public class ResponseWrapper {
        @InvocableVariable(label='Account Name')
        public String accountName;

        @InvocableVariable(label='Industry')
        public String industry;

        @InvocableVariable(label='Phone')
        public String phone;

        @InvocableVariable(label='Annual Revenue')
        public Decimal annualRevenue;

        @InvocableVariable(label='Billing City')
        public String billingCity;
    }

    @InvocableMethod(label='Get Account Details' description='Fetches Account fields for display in a Flow screen')
    public static List<ResponseWrapper> getAccountDetails(List<RequestWrapper> requests) {
        List<ResponseWrapper> responses = new List<ResponseWrapper>();

        for (RequestWrapper req : requests) {
            Account acc = [
                SELECT Name, Industry, Phone, AnnualRevenue, BillingCity
                FROM Account
                WHERE Id = :req.accountId
                LIMIT 1
            ];

            ResponseWrapper resp = new ResponseWrapper();
            resp.accountName    = acc.Name;
            resp.industry       = acc.Industry;
            resp.phone          = acc.Phone;
            resp.annualRevenue  = acc.AnnualRevenue;
            resp.billingCity    = acc.BillingCity;

            responses.add(resp);
        }

        return responses;
    }
}