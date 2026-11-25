public class ContactTriggerHandler {

 public static void updateActiveContactCount(List<Contact> newRecords,List<Contact> oldRecords,Map<Id,Contact> oldMap,System.TriggerOperation operation){


    Set<Id> accountIds = new Set<Id>();


// INSERT / UNDELETE: new contacts that are active

  if(operation==System.TriggerOperation.AFTER_INSERT ||operation==System.TriggerOperation.AFTER_UNDELETE){
   for(Contact con:newRecords){
                   if(con.AccountId!=null){
                         accountIds.add(con.AccountId);
                         }
         
                      }


    }


// UPDATE: Active flag changed OR Account changed
if(operation==System.TriggerOperation.AFTER_UPDATE){

for(Contact con :newRecords){

          Contact oldacc = oldMap.get(con.Id);

       if(con.Active__c!=oldacc.Active__c ||con.AccountId!=oldacc.AccountId){

           if(con.AccountId!=null){
                                    accountIds.add(con.AccountId);
                          }

                   if(oldacc.AccountId!=null){

                                                accountIds.add(oldacc.AccountId);
                      }
                 }
       
               
               }




         }



//DELETE: removed contacts that were active

if(operation==System.TriggerOperation.AFTER_DELETE){

for(Contact con:oldRecords){

      if(con.AccountId!=null &&  con.Active__c){


                       }

           accountIds.add(con.AccountId);
                     }




     }

if(accountIds.isEmpty()){
   return;

 }

// Count active contacts per account (bulk-safe, one query)

Map<Id,Integer> mapcontact = new Map<Id,Integer>();

for(AggregateResult  ar :[SELECT AccountId accId,COUNT(Id)totalcount FROM Contact WHERE AccountId IN: accountIds AND Active__c=true GROUP BY AccountId]){

    mapcontact .put((Id)ar.get('accId'),(Integer)ar.get('totalcount'));


   }

List<Account> updateList = new List<Account>();

for(Id accId : mapcontact.keySet()){

           updateList.add(new Account(Id=accId,Active_Contacts__c=mapcontact.get(accId)));

     }
update updateList;






    }

}