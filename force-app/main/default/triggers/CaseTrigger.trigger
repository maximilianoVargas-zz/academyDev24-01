trigger CaseTrigger on Case (after update) {
    if (Trigger.isAfter) {
        if (Trigger.isUpdate) {
            Map<Id,Case> updatedCasesById = new Map<Id,Case>();
            Map<Id,Case> oldCasesById = Trigger.oldMap;

            for (Case aCase : Trigger.new){
                Case oldCase = oldCasesById.get(aCase.Id);
                if(aCase.Result__c != oldCase.Result__c){
                    updatedCasesById.put(aCase.Id, aCase);
                }
            }
            CaseTriggerHandler.relatedResultCase(updatedCasesById);
        }
    }
}