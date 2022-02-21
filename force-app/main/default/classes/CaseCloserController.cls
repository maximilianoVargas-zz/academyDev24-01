public with sharing class CaseCloserController {
    
    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(String accId){
        try {
            return [
                SELECT Id, CaseNumber, Closing_Reason__c, Status
                FROM Case
                WHERE AccountId = :accId
                AND Status != 'Closed'
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable=false)
    public static void updateCases(List<Case> cases){
        /*
        List<Case> inputCases = (List<Case>) JSON.deserialize(
            JSON.serialize(cases),
            List<Case>.class
            );

        System.debug(inputCases);   
*/
        try {
            List<Case> casesToUpdate = new List<Case>();
            for (Case aCase : cases) {
                if (string.isNotBlank(aCase.Closing_Reason__c)) {
                    aCase.Status = 'Closed';
                    casesToUpdate.add(aCase);
                }
            }
            update casesToUpdate;
        } catch (Exception e) {
            System.debug(e.getMessage());
            throw new AuraHandledException(e.getMessage());
        }
    }
}