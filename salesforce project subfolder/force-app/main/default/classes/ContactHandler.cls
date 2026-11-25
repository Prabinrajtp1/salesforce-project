public class ContactHandler {
    
    public static void contactAction(List<Contact> contacts)
        
    {
        
        List<Account> accs = new List<Account>();
        
        for(Contact con :contacts)
        {
            if(con.AccountId != null){
                
             Account acc = new Account();
             acc.Id = con.AccountId;
             acc.Description = 'Updated Contact Using Apex Trigger';
             accs.add(acc);
            }
            
        }
        if (!accs.isEmpty()) {
            update accs;
    }

}
}