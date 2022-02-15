trigger CaseTrigger on Case (after insert, before update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
           CaseTriggerHandler.realatedTask(Trigger.new);
        }
    }

    if(Trigger.isBefore){
        if(Trigger.isUpdate){
        
        List<Case> casesToUpdate = new List<Case>();

        List<Case> childCases = [
        SELECT Id, Result__c, ParentId
        FROM Case
        WHERE ParentId IN :Trigger.newMap.keySet()
    ];

        for(Case aChildCase : childCases){
            Case aParentCase = Trigger.newMap.get(aChildCase.ParentId);
            if(aChildCase.Result__c != aParentCase.Result__c){
                casesToUpdate.add(aChildCase);
            }
        }
            CaseTriggerHandler.relatedCase(Trigger.newMap, casesToUpdate);
        }
    }
}