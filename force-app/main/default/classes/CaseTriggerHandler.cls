public with sharing class CaseTriggerHandler {
    
    public static void assignLatestCallToCase(List<Case> cases) {
        Map<Id, Case> casesByContactId = new Map<Id, Case>();

        for (Case aCase : cases) {
            casesByContactId.put(aCase.ContactId, aCase);
        }

        Datetime twoMinutesBefore = Datetime.now().addMinutes(-2);

        List<Task> tasks = [
            SELECT Id, WhoId
            FROM Task
            WHERE WhatId = null
            AND WhoId IN :casesByContactId.keySet()
            AND CreatedDate >= :twoMinutesBefore
        ];

        for (Task aTask : tasks) {
            Case aCase = casesByContactId.get(aTask.WhoId);
            aTask.WhatId = aCase.Id;
        }

        if(tasks.size() > 0){ 
            update tasks;
        }
    }

    public static void changeAssociatedCase(Map<Id,Case> newCases, Map<Id,Case> oldCases) {
        Map<String, String> resultToUpdateByCaseId = new Map<String, String>();
        for (Id caseId : newCases.keySet()) {
            if(newCases.get(caseId).Result__c != oldCases.get(caseId).Result__c) {
                resultToUpdateByCaseId.put(newCases.get(caseId).ParentId, newCases.get(caseId).Result__c);
            }
        }
        List<Case> parentCasesToUpdate = [
            SELECT Id, Result__c
            FROM Case
            WHERE Id IN :resultToUpdateByCaseId.keySet()
        ];
        for(Case parentCase : parentCasesToUpdate) {
            parentCase.Result__c = resultToUpdateByCaseId.get(parentCase.Id);
        }
        if(parentCasesToUpdate.size() > 0) {
            update parentCasesToUpdate;
        }
    }
}