public class InactiveOpportunityBatch implements Database.Batchable<sObject> ,Database.Stateful{

public Integer successRecordCount =0;
public Integer failureRecordCount=0;


//start method

public  Database.QueryLocator start(Database.BatchableContext BC){


Datetime cutoffDate = System.now().addDays(-90);
   return Database.getQueryLocator('SELECT  Id,Name,StageName,CreatedDate,LastModifiedDate FROM Opportunity WHERE IsClosed = false AND LastModifiedDate<:  cutoffDate');


}

//Execute records

public void execute(Database.BatchableContext BC,List<Opportunity> scope){

  List<Opportunity> updateOppsList =new List<Opportunity>();

        for(Opportunity opp : scope)
        {

            opp.StageName='Prospecting';
            opp.Description ='Automatically closed due to 90 days inactivity';
         
          updateOppsList .add(opp);
       }

     Database.SaveResult[] results =Database.update(updateOppsList, false);

            for(Database.SaveResult sr: results){
                   if(sr.isSuccess()){
                   successRecordCount++;
                        }
                     else {
                     failureRecordCount++;
                     }

                }


      }
 

public void finish(Database.BatchableContext BC)
{

        System.debug('Batch execution completed');
        System.debug('Successful: ' + successRecordCount);
        System.debug('Failed: ' + failureRecordCount);

}



}