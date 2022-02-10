public with sharing class NewCaseListController {
    public List<Case> getNewCases() {
        List<Case> results = [SELECT Id, CaseNumber 
                                FROM Case 
                                WHERE status='New'];
        return results;
    }
}