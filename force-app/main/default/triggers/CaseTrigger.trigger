trigger CaseTrigger on Case (after insert, after update) {

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            CaseTriggerHandler.realatedTask(Trigger.new);
        }
        if(Trigger.isUpdate){
            CaseTriggerHandler.updateRelatedCases(Trigger.new);
        }
    }

}