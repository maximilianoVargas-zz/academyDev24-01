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

    public static void relatedCase(Map<Id,Case> parentCasesById){
        List<Case> childCases = [
                                SELECT Id, Result__c, ParentId
                                FROM Case
                                WHERE ParentId IN :parentCasesById.keySet()
                                ];

        for(Case aChildCase : childCases){
            Case aParentCase = parentCasesById.get(aChildCase.ParentId);
            if(aChildCase.Result__c != aParentCase.Result__c){
                aChildCase.Result__c = aParentCase.Result__c;
            }
        }

        update childCases;
    }
}