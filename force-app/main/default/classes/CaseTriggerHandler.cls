public with sharing class CaseTriggerHandler {
    public static void updateParentIds(List<Case> cases){
        List<Case> childCases = [SELECT Id,
                                Result__c,
                                ParentId
                                From Case
                                WHERE Id = :cases];
         
        List<Id> parentIds = New List<Id>();
            for (Case caseChild : childCases){
                parentIds.add(caseChild.ParentId);
            }    
            
        List<Case> parentCases = [SELECT Id,
                            Result__c
                            From Case
                            WHERE Id = :parentIds];
        
        Map<String, Case> casesByParentId = new Map<String, Case>();
        for (Case aCase : childCases) {
            casesByParentId.put(aCase.ParentId, aCase);
        }
        List<Case> updatedCases = new List<Case>();
        for (Case aCase : parentCases) {
            if(casesByParentId.containsKey(aCase.Id)){
                aCase.Result__c = casesByParentId.get(aCase.Id).Result__c;
                updatedCases.add(aCase);
            }
        }
        update updatedCases;
    }
}