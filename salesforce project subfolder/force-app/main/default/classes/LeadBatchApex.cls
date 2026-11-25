public class LeadBatchApex implements Database.Batchable<sObject> {
    
    //START: Collects the records or objects to be passed to the execute method
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        String query = 'SELECT Id,Name,Rating FROM Lead';
        return Database.getQueryLocator(query);
        
    }
    
    //Execute:Performs the operations on each chunk of records
    public void execute(Database.BatchableContext BC,List<Lead> scope){
        //process each chunk of the record
        for(Lead led : scope)
        {
            led.Rating = 'Hot';
        }
        update scope;
    }
    
    //Finish: Runs once after all batches are processed
    public void finish(Database.BatchableContext BC)
    {
        System.debug('Batch processing completed successfully');
    }

    
    

}