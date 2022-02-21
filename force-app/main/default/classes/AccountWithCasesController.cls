public with sharing class AccountWithCasesController {

    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(String accountId){
        List<Case> cases = [
            SELECT Id, CaseNumber, Closing_Reason__c, CreatedDate
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
            if (aCase.Closing_Reason__c != '' && aCase.Closing_Reason__c != null) {
                aCase.Status = 'Closed';
            }
        }
        update cases;
    }
}