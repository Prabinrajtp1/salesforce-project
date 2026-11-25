public class CaseTriggerHandler {
    
    public static void handler(List<Case> newList,Map<Id,Case> oldCase,Boolean isDelete )
        
    {
                Set<Id> accountIds = new Set<Id>();
                
                            // New / undeleted / updated cases
                            
                            if(newList !=null){
                                
                                for(Case newcase : newList){
                                    
                                    if(newcase.accountId !=null) accountIds.add(newcase.accountId);
        
                                    
                                    if(oldCase !=null && oldCase.containsKey(newCase.Id)){
                                        Case oldc = oldCase.get(newcase.Id);
                                    if(oldc.AccountId !=null) accountIds.add(oldc.AccountId);
          
                                    }
                                    
                                }
                            }
        
        
            //Initialize all counts to 0
            if(accountIds.isEmpty()) return;
            Map<Id,Account> accountMap = new Map<Id,Account>();
            for(Id accId : accountIds){
                accountMap.put(accId,new Account(
                Id=accId,
                Count_Email__c =0,
                Count_Phone__c = 0,
                Count_Web__c = 0
                ));
            }
        
        
        // Aggregate by Account and Origin
        
        for(aggregateresult ar : [SELECT AccountId,COUNT(Id)cnt ,Origin FROM Case WHERE AccountId IN:accountIds AND Origin IN('Web','Phone','Email') GROUP BY AccountId,Origin  ])
        {
                       //store all values into a variable
                        Id accoutId = (Id) ar.get('AccountId');
                        String origin = (String) ar.get('Origin');
                        Integer Count = (Integer) ar.get('cnt');
            
                       //Assign to accountMap
                       Account acc = accountMap.get(accoutId);
                       if(origin=='Web') acc.Count_Web__c = Count;
                       if(origin=='Phone') acc.Count_Phone__c = Count;
                       if(origin=='Email') acc.Count_Email__c = Count;


          
        }
         update accountMap.values();          

        
        
    }

}