public with sharing class CaseTriggerHandler {
    public static void realatedCases(List<Case> cases) {
        Map<String, Case> casesByParentId = new Map<String, Case>();

            for (Case aCase : cases) {
                casesByParentId.put(aCase.ParentId, aCase);
            }
            List<Case> allCases = [
                SELECT Id,ParentId, Result__c
                FROM Case
                WHERE Id 
                IN :casesByParentId.keySet()
                ];

            List<Case> updatedCases = new List<Case>();
            for (Case aCase : allCases) {
                if(casesByParentId.containsKey(aCase.Id)){
                    aCase.Result__c = casesByParentId.get(aCase.Id).Result__c;
                    updatedCases.add(aCase);
                }
            }

            update updatedCases;
    }
}