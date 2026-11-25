trigger OpportunityAmountValidate on Opportunity (before insert,before update) {

    Set<Id> accountIds = new Set<Id>();
    
    for(Opportunity opps :Trigger.new){
        if(opps.AccountId !=null)
        {
            accountIds.add(opps.AccountId);
        }
        
    }
    
    Map<Id,Account> accounts = new Map<Id,Account>([SELECT Id,Name FROM Account WHERE Id IN:accountIds]);
    
    for(Opportunity opps:Trigger.new){
        if((opps.AccountId !=null) && (opps.Amount !=null) && (opps.Amount>accounts.get(opps.AccountId).AnnualRevenue))
        {
           opps.addError('Opportunity amount cannot exceed Account annual revenue');
        }

    }
        
    
}