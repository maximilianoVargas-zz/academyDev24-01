public with sharing class CloseCaseController {
 
    @AuraEnabled(cacheable=true)
    public static List<Case> getOpenCases (String accountId){
        return [SELECT CaseNumber, Status, Cancel_Reason__c, AccountId
                FROM Case 
                WHERE AccountId = :accountId AND
                Status != 'Closed'
                ];
    }

    @AuraEnabled
    public static String updateCases(Object data){
        List<Case> casesForUpdate = (List<Case>) JSON.deserialize(
            JSON.serialize(data),
            List<Case>.class
        );
        try {
            update casesForUpdate;
            return 'Success: Cases updated successfully';
        }
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
}
