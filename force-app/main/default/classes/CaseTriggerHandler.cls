public with sharing class CaseTriggerHandler {
    public static void updateRelatedCasesResult(List<Case> cases){
        Map<Id, Case> casesByParentId = new Map<Id, Case>();

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
            AND CreatedDate >= :aDate
        ];

        for (Task aTask : tasks) {
            Case aCase = casesByContactId.get(aTask.WhoId);
            aTask.WhatId = aCase.Id;
        }

        update tasks;
    }
}