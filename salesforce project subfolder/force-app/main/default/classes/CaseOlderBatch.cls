public with sharing class CaseOlderBatch implements Database.Batchable<SObject>, Database.RaisesPlatformEvents {

   public Integer deletedRecordCount =0;

   //Start method

   public Database.QueryLocator start(Database.BatchableContext bc){

  Date cutoff = Date.today().addYears(-3);

   return Database.getQueryLocator('SELECT Subject,CaseNumber,ClosedDate FROM Case WHERE IsClosed = true AND  ClosedDate<=:cutoff ');

   }

//Execute Method

public void execute(Database.BatchableContext bc,List<Case> scope){

//first add case records into big object

List<Case_Archive__b> archieveRecords = new List<Case_Archive__b>();

for(Case co :scope){

     Case_Archive__b  archieveRecord = new   Case_Archive__b();
        
         archieveRecord.Subject__c=co.Subject;
       archieveRecord.CaseNumber__c = co.CaseNumber ;
       archieveRecord.Closed_Date__c=co.ClosedDate;
       archieveRecords.add( archieveRecord);
      }
  Database.insertImmediate( archieveRecords);

//Delete those case records

Database.DeleteResult[] results = Database.delete(scope, false);
for (Database.DeleteResult dr : results)
{
if (dr.isSuccess()) deletedRecordCount++;
}
Database.emptyRecycleBin(scope);
}

//finish method

  public void finish(Database.BatchableContext BC){

        System.debug('Archived and deleted ' + deletedRecordCount+ ' cases');

            }



}