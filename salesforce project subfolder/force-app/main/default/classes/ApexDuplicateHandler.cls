public class ApexDuplicateHandler {
    
    public static void accountDuplicateHandler(List<Account> newAccounts,Map<Id,Account> oldAccount){
        
        Set<String> accountNames = new Set<String>();
        
                //Collect the new accounts and add into the set
                
                for(Account acc :newAccounts){
                    if(String.isNotBlank(acc.Name)){
                        accountNames.add(acc.name.trim().toLowerCase());
                        
                    }
                   
                } 
        
             //if accountnames set is blank then return
                if(accountNames.isEmpty()){
                    return;
                }
             
             //Find existing Accounts with same names
             Map<String,Account> existingaccounts = new Map<String,Account>();
                for(Account acc :[SELECT Id,Name FROM Account WHERE Name IN:accountNames]){
                    existingaccounts.put(acc.Name.trim().toLowerCase(),acc);
                }
             
            //Check Duplicates
                    for(Account acc :newAccounts)
                    {
                        if(String.isNotBlank(acc.Name))
                        {
                            String accountName = acc.Name.trim().toLowerCase();
                        
                    
                    if(existingaccounts.containsKey(accountName))
                    {
                        Account existingAccount = existingaccounts.get(accountName);
                        
                        // For update, don't compare the record with itself
                            if (acc.Id == null || acc.Id != existingAccount.Id) {
                                acc.addError(
                                    'Duplicate Account: An Account with the name "' +
                                    acc.Name +
                                    '" already exists.'
                                );
                            }
                    }
            
            
                    }
                        
            
                  }
                    
 
        
    }

}