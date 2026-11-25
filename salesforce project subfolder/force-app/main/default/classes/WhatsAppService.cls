public with sharing class WhatsAppService {

    @AuraEnabled
    public static String sendTemplateMessage(
        String toPhone,
        String customerName,
        String orderNumber,
        String orderDate
    ) {

        // 1. Create HTTP request
        HttpRequest req = new HttpRequest();

        req.setEndpoint(
            'callout:WhatsApp_Cloud_API/v25.0/1482124854975633/messages'
        );

        req.setMethod('POST');
        req.setHeader('Content-Type', 'application/json');

        // 2. Create template parameters
        List<Object> parameters = new List<Object>();

        parameters.add(new Map<String, Object>{
            'type' => 'text',
            'text' => customerName
        });

        parameters.add(new Map<String, Object>{
            'type' => 'text',
            'text' => orderNumber
        });

        parameters.add(new Map<String, Object>{
            'type' => 'text',
            'text' => orderDate
        });

        // 3. Create template body component
        Map<String, Object> bodyComponent =
            new Map<String, Object>{
                'type' => 'body',
                'parameters' => parameters
            };

        // 4. Create template
        Map<String, Object> template =
            new Map<String, Object>{
                'name' => 'jaspers_market_order_confirmation_v1',
                'language' => new Map<String, Object>{
                    'code' => 'en_US'
                },
                'components' => new List<Object>{
                    bodyComponent
                }
            };

        // 5. Create final JSON request
        Map<String, Object> requestBody =
            new Map<String, Object>{
                'messaging_product' => 'whatsapp',
                'to' => toPhone,
                'type' => 'template',
                'template' => template
            };

        req.setBody(JSON.serialize(requestBody));

        // 6. Send API request
        Http http = new Http();

        HttpResponse res = http.send(req);

        // 7. Handle response
        if (res.getStatusCode() == 200 ||
            res.getStatusCode() == 201) {

            System.debug('WhatsApp message sent successfully');

            return res.getBody();

        } else {

            System.debug('WhatsApp API Error: ' + res.getBody());

            throw new AuraHandledException(
                'WhatsApp API Error: ' + res.getBody()
            );
        }
    }
}