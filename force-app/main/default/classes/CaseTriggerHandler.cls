public with sharing class CaseTriggerHandler {
    public static void updateAssociatedCases(List<Case> cases){
        Map<Id, Case> casesByParentId = new Map<Id, Case>();

        for (Case aCase : cases) {
            casesByParentId.put(aCase.ParentId, aCase);
        }

        List<Case> parentCases = [
            SELECT Id, Result__c
            FROM Case
            WHERE Id IN :casesByParentId.keySet()
        ];

        for(Case aCase : parentCases){
                aCase.Result__c = casesByParentId.get(aCase.Id).Result__c;
        }

        update parentCases;
    }
}