trigger CaseTrigger on Case (after insert, after update) {
    if (Trigger.isAfter){
        if (Trigger.isInsert){
            CaseTriggerHandler.relateTask(Trigger.new);
        }
        if (Trigger.isUpdate){
            CaseTriggerHandler.updateRelatedCases(Trigger.new);
        }
    }
}