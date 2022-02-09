trigger CaseTrigger on Case (after insert, after update) {

    if(Trigger.isAfter) {
        if(Trigger.isUpdate) {
            List<Case> cases = new List<Case>();
            for(Case aCase : Trigger.new) {
                Case aCaseToCompare = Trigger.oldMap.get(aCase.Id);
                if(aCase.ParentId != null &&  aCase.Result__c != aCaseToCompare.Result__c) {
                    cases.add(aCase);
                }
            }
            CaseTriggerHandler.updateParentCaseWithCaseResult(cases);
        } else if(Trigger.isInsert) {
            CaseTriggerHandler.realatedTask(Trigger.new);
        }
    }

}