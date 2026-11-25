public class SecureAPIIntegration {

    public static void getExternalData() {

        Http http = new Http();

        HttpRequest request = new HttpRequest();

        // Named Credential endpoint
        request.setEndpoint(
            'https://api.collectapi.com/imdb/imdbSearchByName?query=inception'
        );

        request.setMethod('GET');

        request.setHeader(
            'authorization',
            'apikey 0FCIUGaICyiZNK0CsSFe55:4EiLS1NoD74T0VXFdApOnu'
        );

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {

            System.debug('Success: ' + response.getBody());

        } else {

            System.debug('Error: ' + response.getStatusCode());
            System.debug('Message: ' + response.getBody());
        }
    }
}