public class LeadAsynchrnousFuture {
    @future
    //updating Lead Records 
    //Note:Future method should contain Static and Void
    //Note:Only Support primitive datatypes like Id,String,etc...
    
    public static void updatingLeadRecords(List<Id> leadrecordIds)
    {
        List<Lead> leadrecords = [Select Id,Name FROM Lead WHERE Id IN:leadrecordIds];
        for(Lead acc :leadrecords)
        {
           acc.Rating ='Hot'; 
        }
        update leadrecords; 
        
    }

}