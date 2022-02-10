trigger CaseTrigger on Case (after update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){

            CaseTriggerHandler.realatedCases(Trigger.New);
        }
    }
}