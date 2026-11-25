trigger AccountDuplicateTrigger on Account (before insert,before update)

    {
         ApexDuplicateHandler.accountDuplicateHandler(Trigger.new, Trigger.oldMap);
      
    }