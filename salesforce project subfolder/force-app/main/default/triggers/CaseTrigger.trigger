trigger CaseTrigger on Case (
    after insert,
    after update,
    after undelete
) {
    
    CaseTriggerHandler.handler(
        Trigger.new,
        Trigger.oldMap,
        false
    );
}