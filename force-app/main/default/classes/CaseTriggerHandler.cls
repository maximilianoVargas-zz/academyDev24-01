public with sharing class CaseTriggerHandler {
    
    public static void updateParentCaseWithCaseResult(List<Case> cases) {

        Map<Id, Case> casesByParentId = new Map<Id, Case>();
        for(Case aCase : cases) {
            casesByParentId.put(aCase.ParentId, aCase);
        }

        List<Case> parentCases = [
            SELECT Id, Result__c
            FROM Case
            WHERE Id IN :casesByParentId.keySet()
        ];

        for(Case aCase : parentCases) {
            Case aCaseWithResult = casesByParentId.get(aCase.Id);
            aCase.Result__c = aCaseWithResult.Result__c;
        }

        update parentCases;

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