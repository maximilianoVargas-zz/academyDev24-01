public with sharing class closeCases {

    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(String accountId){
        List<Case> cases = [
            SELECT Id, CaseNumber, Cancellation_Reason__c, CreatedDate
            FROM Case
            WHERE AccountId = :accountId
            AND Status != 'Closed'
            LIMIT 100
        ];
        return cases;
    }
    @AuraEnabled
    public static void updateCases(List<Case> cases){
        for(Case aCase : cases){
            if (aCase.Cancellation_Reason__c != '' && aCase.Cancellation_Reason__c != null) {
                aCase.Status = 'Closed';
            }
        }
        update cases;
    }
}