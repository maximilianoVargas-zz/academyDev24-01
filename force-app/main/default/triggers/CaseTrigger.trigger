trigger CaseTrigger on Case (after insert, after update) {

    if (Trigger.isInsert) {

        CaseTriggerHandler.relatedCaseWithTask(Trigger.new);

    } else if (Trigger.isUpdate) {

        Map<Id, Case> casesById = Trigger.oldMap;
        List<Case> casesToUpdate = new List<Case>();

        for (Case aCase : Trigger.new) {
            Case oldCase = casesById.get(aCase.Id);
            if (aCase.Result__c != oldCase.Result__c) {
                casesToUpdate.add(aCase);
            }
        }

        CaseTriggerHandler.updateResultInAssociatedCases(casesToUpdate);
    }
    
}