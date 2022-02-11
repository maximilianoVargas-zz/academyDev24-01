public with sharing class CaseTriggerHandler {
    public static void relatedResultCase(Map<Id,Case> cases){
        /** Trigger presentation EX 2*/
        List<Case> relatedCases = [
            SELECT Id, ParentId, Result__c
            FROM Case
            WHERE ParentId IN :cases.keySet()
            WITH SECURITY_ENFORCED
        ];

        List<Case> updateCase = new List<Case>();
        for(Case aCase : relatedCases){
            aCase.Result__c = cases.get(aCase.ParentId).Result__c;
            updateCase.add(aCase);
        }

        if (!Schema.sObjectType.Case.fields.Result__c.isUpdateable()) {
            return ;
        }

        update updateCase;
    }
}