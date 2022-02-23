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

    public static void relatedCase(Map<Id, Case> casesById, List<Case> childCasesToUpdate){

        List<Case> casesToUpdate = new List<Case>();
        
        for(Case aChildCase : childCasesToUpdate){
            Case aParentCase = casesById.get(aChildCase.ParentId);
            aChildCase.Result__c = aParentCase.Result__c;

            casesToUpdate.add(aChildCase);
        }
        update casesToUpdate;
    }
}