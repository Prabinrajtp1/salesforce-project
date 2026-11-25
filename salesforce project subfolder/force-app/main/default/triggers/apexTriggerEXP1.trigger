trigger apexTriggerEXP1 on Account (before insert,before update)
{

    for(Account acc :Trigger.new)
    {
        if(acc.Industry == 'Banking' || acc.Industry == 'Healthcare' )
        {
          acc.Rating ='Hot' ; 
        }
    }
    
}