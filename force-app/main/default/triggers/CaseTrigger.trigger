trigger CaseTrigger on Case (after update, after insert) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            CaseTriggerHandler.realatedCases(Trigger.new);
        } else if (Trigger.isInsert){
            CaseTriggerHandler.realatedTask(Trigger.new);
        }
    }
}