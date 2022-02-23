public with sharing class closeCasesFromAccountController {
    @AuraEnabled(cacheable=true)
    public static List<Case> getCasesByAccountId(Id AccountId){
        return [
            SELECT Id, Close_Reason__c, CaseNumber, Status
            FROM Case
            WHERE AccountId = :AccountId
        ];
    }

    @AuraEnabled
    public static string updateCases(Object data) {
    List<Case> casesForUpdate = (List<Case>) JSON.deserialize(
         JSON.serialize(data),
         List<Case>.class
    );

        List<Case> casesToUpdate = new List<Case>();
        Boolean caseWithNoReason = false;

        for (Case aCase : casesForUpdate) {
            if(String.isBlank(aCase.Close_Reason__c)){
                caseWithNoReason = true;
            } else{
                aCase.Status = 'Closed';
                casesToUpdate.add(aCase);
            }
        }

        if(caseWithNoReason == true){
            return 'Close reason field is required';
        }
        else{
            update casesToUpdate;
            return 'Success: cases updated successfully';
        }
    }
}
