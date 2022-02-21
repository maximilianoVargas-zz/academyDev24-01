public with sharing class CaseController {

    @AuraEnabled(Cacheable=true)
    public static List<Case> getCasesByAccount(String idAccount) {    
        return [
            SELECT
                Id, CaseNumber,
                Description, Status
            FROM Case
            WHERE AccountId = :idAccount
            AND Status != 'Closed'
        ];
    }

    @AuraEnabled
    public static void updateCases(Object cases) {

        List<Case> casesToUpdate = (List<Case>) JSON.deserialize(
            JSON.serialize(cases),
            List<Case>.class
        );
        
        update casesToUpdate;
    }
}
