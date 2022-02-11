public with sharing class CaseTriggerHandler {
    public static void updateParentIds(List<Case> cases){

        Map<String, Case> casesByParentId = new Map<String, Case>();
        for (Case aCase : cases) {
            casesByParentId.put(aCase.ParentId, aCase);
        }

        List<Case> parentCases = [
            SELECT Id, Result__c
            FROM Case
            WHERE Id = :casesByParentId.keySet()
        ];

        List<Case> updatedCases = new List<Case>();
        for (Case aCase : parentCases) {
            aCase.Result__c = casesByParentId.get(aCase.Id).Result__c;
            updatedCases.add(aCase);
        }
        update updatedCases;
    }
}