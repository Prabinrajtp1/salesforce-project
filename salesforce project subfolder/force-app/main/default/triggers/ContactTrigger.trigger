trigger ContactTrigger on Contact (after insert, after update, after delete, after undelete) {

    ContactTriggerHandler.updateActiveContactCount(
        Trigger.new, Trigger.old, Trigger.oldMap, Trigger.operationType
    );

}