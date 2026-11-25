public with sharing class CurrencyButtonController {

    public class Request {
        @InvocableVariable(required=true label='Base Currency')
        public String baseCurrency;

        @InvocableVariable(required=true label='Target Currency')
        public String targetCurrency;
    }

    public class Response {
        @InvocableVariable(label='Exchange Rate')
        public Decimal exchangeRate;

        @InvocableVariable(label='Is Success')
        public Boolean isSuccess;

        @InvocableVariable(label='Error Message')
        public String errorMessage;
    }

    @InvocableMethod(label='Get Exchange Rate' description='Fetches the exchange rate for a base/target currency pair and logs it')
    public static List<Response> triggerCallout(List<Request> requests) {
        List<Response> responses = new List<Response>();

        for (Request req : requests) {
            CurrencyRateCallout.ExchangeResult result =
                CurrencyRateCallout.getCurrencyExchange(req.baseCurrency, req.targetCurrency);

            Response res = new Response();
            res.exchangeRate = result.exchangeRate;
            res.isSuccess = result.isSuccess;
            res.errorMessage = result.errorMessage;
            responses.add(res);
        }

        return responses;
    }
}