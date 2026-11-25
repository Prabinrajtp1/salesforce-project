public with sharing class IMBDController {
    @AuraEnabled(cacheable=true)
    public static string getMovieDetails(String searchName){
        try {


        Http http = new Http();

        HttpRequest request = new HttpRequest();

        // Named Credential endpoint
        //request.setEndpoint( 'https://api.collectapi.com/imdb/imdbSearchByName?query='+searchName );
        //INSTED USED IN Named Credentials
         request.setEndpoint('callout:IMBD/imdb/imdbSearchByName?query='+searchName );

        request.setMethod('GET');

        //MAKE IT AS COMMENTS REFERED IN NAMED CREDENTIALS
        //request.setHeader('authorization','apikey 0FCIUGaICyiZNK0CsSFe55:4EiLS1NoD74T0VXFdApOnu');

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {

            //System.debug('Success: ' + response.getBody());
            String responseBody=response.getBody();
           return  responseBody;

        } else {

            String errorMessage='Error: ' + response.getStatusCode();
           // System.debug('Message: ' + response.getBody());

           return errorMessage;
        }
    }
        
        catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}