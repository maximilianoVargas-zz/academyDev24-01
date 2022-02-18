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
                AND CreatedDate >= :aDate
            ];

            for (Task aTask : tasks) {
                Case aCase = casesByContactId.get(aTask.WhoId);
                aTask.WhatId = aCase.Id;
            }

            update tasks;
    }

    public static void copyCaseResultToRelatedCases(List<Case> cases){

        Map<Id,Case> parentCasesById = new Map<Id,Case>();

        for (Case aCase : cases) {
            parentCasesById.put(aCase.ParentId, acase);
        }

        List<Case> relatedCases = [
               SELECT Id, ParentId, Result__c 
               FROM Case
               WHERE Id IN :parentCasesById.keySet()
        ];

        for( Case aRelatedCase : relatedCases){
            Case aCase = parentCasesById.get(aRelatedCase.ParentId);
            aRelatedCase.Result__c = aCase.Result__c;
        }

        update relatedCases;
    }
}