trigger CaseTrigger on Case (after update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            CaseTriggerHandler.updateCases(trigger.new);
        }

        if (Trigger.isInsert) {
            CaseTriggerHandler.realatedTask(Trigger.new);
         }
    }
}