public with sharing class CaseManage {
    
    public static void relatedCaseWithTask(List<Case> cases) {
                
        Map<String, Case> casesByContactId = new Map<String, Case>();
        
        for(Case aCase  : cases) {
            if (aCase.ContactId != null) {
                casesByContactId.put(aCase.ContactId, aCase);
            }
        }

        DateTime initialDate = DateTime.now().addMinutes(-2);

        List<Task> tasks = [Select Id, WhoId 
                            From Task Where WhoId IN :casesByContactId.keySet() 
                            AND CreatedDate >= :initialDate 
                            AND WhatId = NULL];
              
        for (Task aTask : tasks) {
            Case aCase = casesByContactId.get(aTask.WhoId);
            aTask.WhatId = aCase.Id;
        }

        update tasks;
    }

    public static void updateResultInAssociatedCases(List<Case> cases) {

        List<Case> casesToUpdate = [Select Id, Result__c, Parent.Result__c 
                                    From Case Where ParentId IN :cases];
        
        for (Case aCase : casesToUpdate) {
            aCase.Result__c = aCase.Parent.Result__c;
        }

        update casesToUpdate;

    }
}