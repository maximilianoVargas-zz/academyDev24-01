public with sharing class CaseController {

    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(string accountId){
        try {
             if(string.isBlank(accountId) || string.isEmpty(accountId)) {
                return null;
             }                 
            return [
                SELECT Id, CreatedDate, CaseNumber, Reason, Closing_reason__c 
                FROM Case
                WHERE AccountId = :accountId
                AND Status != 'Closed'
                LIMIT 50
            ];            
        } catch (Exception e) {            
            throw new AuraHandledException(e.getMessage());
        }
    }

 
    @AuraEnabled
    public static string updateCases(Object data) {
        List<Case> casesForUpdate = (List<Case>) JSON.deserialize(
             JSON.serialize(data),
             List<Case>.class
        );        
        try {            
            List<Case> casesSuccess = new List<Case>();
            for (Case aCase : casesForUpdate) {
                if (string.isNotEmpty(aCase.Closing_reason__c) && string.isNotBlank(aCase.Closing_reason__c)) {
                    aCase.Status = 'Closed';                    
                    casesSuccess.add(aCase);
                }
            }
            update casesSuccess;            
            return 'Success: cases updated successfully';
        }
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }

}