public with sharing class CaseTriggerHandler2 {

    public static void UpdatePrincipalCase(List<Case> ListCases){

        List<Case> ListCasesUpdate=new List<Case>();

        for (Case aCase : ListCases) {
            if (aCase.ParentId!=null) {

                Case PrincipalCase=[
                    SELECT Id, Result__c 
                    FROM Case 
                    WHERE Id=:aCase.ParentId];

                PrincipalCase.Result__c=aCase.Result__c;
                ListCasesUpdate.add(PrincipalCase);
                
                update ListCasesUpdate;
            }
        }
    }   
}
