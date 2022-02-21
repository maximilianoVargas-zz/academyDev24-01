public with sharing class CaseTriggerHandler {
    public static void realatedTask(List<Case> cases) {
        Map<Id, Case> casesByContactId = new Map<Id, Case>();

            for (Case aCase : cases) {
                casesByContactId.put(aCase.ContactId, aCase);
            }

            Datetime aDate = Datetime.now().addMinutes(-2);

            List<Task> tasks = [
                SELECT Id, WhoId
                FROM Task
                WHERE WhatId = null
                AND WhoId IN :casesByContactId.keySet()
            ];

            for (Task aTask : tasks) {
                Case aCase = casesByContactId.get(aTask.WhoId);
                aTask.WhatId = aCase.Id;
            }
            update tasks;
    }

    public static void updateRelatedCases(List<case> cases){
        
        Map<Id, String> casesByResult = new Map<Id, String>();
        for (Case aCase : cases) {
            casesByResult.put(aCase.Id, aCase.Result__c);
        }

        List<Case> relatedCases = [ 
            SELECT Id, Result__c, ParentId FROM Case WHERE ParentId IN :casesByResult.keySet()
        ];

        for(Case aCase: relatedCases){
            aCase.Result__c = casesByResult.get(aCase.ParentId);
        }

        update relatedCases;

    }
}
