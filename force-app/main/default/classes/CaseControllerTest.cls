@IsTest
public with sharing class CaseControllerTest {
    
    @TestSetup
    static void makeData(){

        Account anAccount = new Account( 
            Name = 'Account 1',
            Identification_type__c = 'NIT', 
            Document_number__c = '1234'
        );
        insert anAccount;

        List<Case> cases = new List<Case>();

        for (Integer i = 1; i <= 10; i++) {

            Case aCase = new Case(
                Status = 'New',
                AccountId = anAccount.Id
            );

            cases.add(aCase);
        }

        insert cases;
    }

    @IsTest static void shouldGetAllCasesRelatedAccount() {

        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'Account 1'
        ];

        Test.startTest();
        List<Case> cases = CaseController.getCasesByAccount(anAccount.Id);
        Test.stopTest();

        System.assertEquals(10, cases.size(), 'Should be 10 cases related to account');
    }

    @IsTest static void shouldUpdateCases() {

        List<Case> cases = [
            SELECT Id
            FROM Case
            LIMIT 1
        ];
        cases.get(0).Status = 'Closed';

        Test.startTest();
        CaseController.updateCases(cases);
        Test.stopTest();

        Case caseUpdated = [
            SELECT Id, Status
            FROM Case
            WHERE Id = :cases.get(0).Id
        ];

        System.assertEquals('Closed', caseUpdated.Status, 'Status should be Closed');
    }
}
