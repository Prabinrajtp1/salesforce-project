@RestResource(urlMapping='/myAccounts/*')
global class RestWebserviceSample {
    
    @HttpGet
    
    global static List<Account> getAccounts(){
        List<Account> accounts = [SELECT Id ,Name,Rating,Phone,Industry FROM Account LIMIT 10];
        return accounts;
    }

}