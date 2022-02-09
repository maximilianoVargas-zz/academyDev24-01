public with sharing class TriggerExercise2 {
    //TODO - AGREGAR TEST
    //case relacionado con case es con el caso padre
    public static void dosomething(List<Case> cases) {
        List<Case> parentCaseToUpdate=new List<Case>();
        Map<Id,Case> parentMap=new Map<Id,Case>();


        for (Case aCase : cases)  {
            if(aCase.Result__c !=null){
                Case parentCase=[select Id, Result__c from Case where Id=:aCase.ParentId];
                parentMap.put(aCase.Id,parentCase);
            }
        }

        for (Case aCase : cases) {
            Case parentCase=parentMap.get(aCase.Id);
            parentCase.Result__c = aCase.Result__c;
            parentCaseToUpdate.add(parentCase);
        }

        update parentCaseToUpdate;
    }

}