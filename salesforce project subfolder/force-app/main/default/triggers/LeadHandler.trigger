trigger LeadHandler on Lead (before insert, after insert) {

    for (Lead leadRecord : Trigger.new) {

        // Before Insert
        if (Trigger.isBefore && String.isBlank(leadRecord.LeadSource)) {

            leadRecord.LeadSource = 'Other';
        }

        // After Insert
        if (Trigger.isAfter) {

            ID LeadID = leadRecord.Id;

            Task newTask = new Task();

            newTask.Subject = 'Created Task from Trigger Run';
            newTask.WhoId = LeadID;
            newTask.OwnerId = leadRecord.OwnerId;
            newTask.Status = 'Not Started';

            insert newTask;
        }
    }
}