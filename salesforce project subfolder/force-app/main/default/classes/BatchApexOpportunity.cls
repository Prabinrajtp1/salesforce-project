public class BatchApexOpportunity implements Database.Batchable<sObject> {

    
    //Start Method

      public Database.QueryLocator start(Database.BatchableContext BC){
 
           return Database.getQueryLocator('SELECT  Id,CloseDate FROM Opportunity WHERE CloseDate < LAST_N_DAYS:30');

            }

  //Execute method

public void execute(Database.BatchableContext BC,List<Opportunity> scope){
       for(Opportunity opp :scope)

        {
              opp.StageName='Closed Lost';
              }

     update scope;
     }

//Finish Method

public void finish(Database.BatchableContext BC)
   {
  System.debug('Batch apex Execution Completed');

   }


}