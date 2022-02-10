trigger CaseTrigger on Case (after insert, before update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
           CaseTriggerHandler.realatedTask(Trigger.new);
        }
    }

    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            CaseTriggerHandler.relatedCase(Trigger.newMap);
        }
    }
}