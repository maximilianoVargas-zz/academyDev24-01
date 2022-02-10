public with sharing class CaseTriggerHandler {

    public static void checkCalls(List<Case> cases){
        Map<Id, Case> contactCases = new Map<Id, Case>();
        
        for(Case aCase : cases){
            contactCases.put(aCase.ContactId, aCase);
        }

        List<Contact> contacts = [
            SELECT Id
            FROM Contact
            WHERE Id IN :contactCases.keySet()
        ];
        Map<Id, Contact> whos = new Map<Id, Contact>();

        for(Contact aContact : contacts){
            whos.put(aContact.Id, aContact);
        }

        List<Task> tasks = [
            SELECT Id, CreatedDate, WhoId, WhatId, Type
            FROM Task
            WHERE WhoId IN :whos.keySet()
            AND Type = 'Call'
        ];

        for(Task aTask : tasks){
            Datetime fecha = contactCases.get(aTask.WhoId).CreatedDate.addMinutes(-2);
            if(aTask.CreatedDate>=fecha){
                aTask.WhatId = contactCases.get(aTask.WhoId).Id;
            }
        }

        update tasks;
    }



    public static void updateAssociatedCases(List<Case> cases){
        Map<Id, Case> casesByParentId = new Map<Id, Case>();

        for (Case aCase : cases) {
            casesByParentId.put(aCase.ParentId, aCase);
        }

        List<Case> parentCases = [
            SELECT Id, Result__c
            FROM Case
            WHERE Id IN :casesByParentId.keySet()
        ];

        for(Case aCase : parentCases){
                aCase.Result__c = casesByParentId.get(aCase.Id).Result__c;
        }

        update parentCases;
    }
}