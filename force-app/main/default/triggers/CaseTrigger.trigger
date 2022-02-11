trigger CaseTrigger on Case (after insert, after update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
           CaseTriggerHandler.realatedTask(Trigger.new);
        }else if(Trigger.isUpdate){
            CaseTriggerHandler.copyCaseResultToRelatedCases(Trigger.new);
        }
    }
}