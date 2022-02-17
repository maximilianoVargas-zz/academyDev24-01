public with sharing class CaseCloserController {

    @AuraEnabled(cacheable=true)
    public static List<Case> getCasesOfAccount(String accountId) {
        List<Case> cases = [
            SELECT Id, CaseNumber, Status
            FROM Case
            WHERE AccountId = :accountId
                AND Status != 'Closed'
        ];
        return cases;
    }

    @AuraEnabled(cacheable=false) // cacheable=false because this method invocation is IMPERATIVE
    public static void closeCases(List<String> caseIds) {
        List<Case> casesToClose = [
            SELECT Id
            FROM Case
            WHERE Id IN :caseIds
        ];
        for (Case aCase : casesToClose) {
            aCase.Status = 'Closed';
        }
        update casesToClose;
    }
}
