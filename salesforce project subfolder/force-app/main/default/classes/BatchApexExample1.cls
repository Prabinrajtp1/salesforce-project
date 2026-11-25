public class BatchApexExample1 implements Database.Batchable<sObject> {

    //start Method
    public Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('SELECT Id,LeadSource FROM Lead');
        
    }
    
    //Execute Method
    public void execute(Database.BatchableContext BC,List<Lead> scope){
        for(Lead led:scope){
            led.LeadSource ='Web';
        }
        update scope;
    }
    
    //finish method
    public void finish(Database.BatchableContext BC){
      System.debug('Batch Apex completed');
    }
    
    
}