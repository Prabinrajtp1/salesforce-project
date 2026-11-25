public with sharing class OpportunityClosedWonRollup implements Database.Batchable<SObject>, Database.RaisesPlatformEvents {

    
    //Start Method

public Database.QueryLocator start(Database.BatchableContext bc){

   return Database.getQueryLocator('Select Id,Name,Total_Closed_Won__c FROM Account');


      }

//Execute Method

public  void execute(Database.BatchableContext bc ,List<Account> scope){


Map<Id,Decimal> resultsMap = new Map<Id,Decimal>();

for(AggregateResult ar:[SELECT AccountId acc,SUM(Amount)total FROM  Opportunity WHERE StageName ='Closed Won'  AND AccountId IN:scope  GROUP BY  AccountId ]){

           Decimal totalAmount = (Decimal) ar.get('total');
           resultsMap.put((Id)ar.get('acc'),totalAmount);
          
       }

List<Account> updateAccountList = new List<Account>();

for(Account acc :scope){

   Decimal amount =  resultsMap.containsKey(acc.id)?resultsMap.get(acc.id):0;

 updateAccountList.add(new Account(Id=acc.Id,Total_Closed_Won__c=amount));

}
Database.update( updateAccountList ,false);


   }

public void finish(Database.BatchableContext bc){
    system.debug('Completed processing records');

   }


}