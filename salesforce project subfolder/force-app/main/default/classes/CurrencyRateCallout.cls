public class CurrencyRateCallout {

    public class ExchangeResult {
        public Boolean isSuccess;
        public Decimal exchangeRate;
        public String errorMessage;
    }

    public static ExchangeResult getCurrencyExchange(String baseCurrency, String targetCurrency) {
        ExchangeResult result = new ExchangeResult();
        result.isSuccess = false;

        String base = baseCurrency.trim().toUpperCase();
        String target = targetCurrency.trim().toUpperCase();

        // TODO: move this to a Named Credential instead of a hardcoded key
        String endpoint = 'https://v6.exchangerate-api.com/v6/d5945ea8cab87e149488dfdb/latest/' + base;

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endpoint);
        req.setMethod('GET');
        req.setTimeout(10000);

        API_Log__c log = new API_Log__c();
        log.Endpoint__c = endpoint;

        try {
            HttpResponse res = http.send(req);

            log.Status_Code__c = res.getStatusCode();
            log.Response_Body__c = res.getBody();
            log.Callout_Status__c = (res.getStatusCode() == 200) ? 'Success' : 'Failed';

            if (res.getStatusCode() == 200) {
                Map<String, Object> jsonMap = (Map<String, Object>) JSON.deserializeUntyped(res.getBody());

                if (jsonMap.get('result') == 'success') {
                    Map<String, Object> rates = (Map<String, Object>) jsonMap.get('conversion_rates');

                    if (rates != null && rates.containsKey(target)) {
                        result.exchangeRate = (Decimal) rates.get(target);
                        result.isSuccess = true;
                    } else {
                        result.errorMessage = 'Target currency "' + target + '" not found in response';
                    }
                } else {
                    result.errorMessage = String.valueOf(jsonMap.get('error-type'));
                }
            } else {
                result.errorMessage = 'HTTP Error: ' + res.getStatusCode();
            }

        } catch (Exception e) {
            result.isSuccess = false;
            result.errorMessage = 'Exception: ' + e.getMessage();
            log.Callout_Status__c = 'Failed';
            log.Response_Body__c = result.errorMessage;
        }

        // Actually persist the computed values onto the log record
        log.Rate_Value__c = result.exchangeRate;
        log.Error_Message__c = result.errorMessage;

        insert log;

        return result;
    }
}