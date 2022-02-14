public with sharing class CaseTriggerHandler {
    public CaseTriggerHandler() {

    }
    public static void realatedTask(List<Case> cases)
    {
        Map<Id, Case> casesByContactId = new Map<Id, Case>();
        for (Case aCase : cases) {
            casesByContactId.put(aCase.ContactId, aCase);
        }

        Datetime aDate = Datetime.now().addMinutes(-2);

        List<Task> tasks = [
            SELECT Id, WhoId
            FROM Task
            WHERE WhatId = NULL
            AND WhoId IN :casesByContactId.keySet()
            AND CreatedDate >= :aDate
        ];

        for (Task aTask : tasks) {
            Case aCase = casesByContactId.get(aTask.WhoId);
            aTask.WhatId = aCase.Id;
        }

        Update tasks;
    }

    public static void updateCaseResultInAssociated(List<Case> cases)
    {
        Map<Id, Case> casesByParent = new Map<Id, Case>();
        for (Case aCase : cases) {
            casesByParent.put(aCase.ParentId, aCase);
        }

        List<Case> associatedCases = [
            SELECT Id, ParentId, Result__c
            FROM Case
            WHERE Id IN :casesByParent.keySet()
        ];        

        for (Case aCase : associatedCases) {
            aCase.Result__c = casesByParent.get(aCase.Id).Result__c;
        }

        update associatedCases;
    }
}