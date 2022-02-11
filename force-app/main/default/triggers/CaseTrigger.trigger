trigger CaseTrigger on Case (after update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            List<Case> cases = new List<Case>();

            for (Case aCase : Trigger.new) {
                Case oldCase = Trigger.oldMap.get(aCase.Id);
                if (aCase.Result__c != oldCase.Result__c) {
                    cases.add(aCase);
                }
            }
            
            CaseTriggerHandler.updateRelatedCasesResult(cases);
        }
        if (Trigger.isInsert) {
            CaseTriggerHandler.realatedTask(Trigger.new);
         }
    }
}