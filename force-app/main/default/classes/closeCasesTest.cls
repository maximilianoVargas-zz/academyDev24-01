@isTest
private with sharing class closeCasesTest {

    @TestSetup
    static void addAccountAndCases(){

        Account anAccount = new Account(Name = 'Test Account');
        insert anAccount;

        List<Case> casesList = new List<Case>();
        casesList.add(new Case(
            AccountId = anAccount.Id,
            Subject = 'Test Subject1',
            Status = 'New',
            Origin = 'Phone',
            Cancellation_Reason__c = ''
        ));
        casesList.add(new Case(
            AccountId = anAccount.Id,
            Subject = 'Test Subject2',
            Status = 'New',
            Origin = 'Phone',
            Cancellation_Reason__c = ''
        ));
        casesList.add(new Case(
            AccountId = anAccount.Id,
            Subject = 'Test Subject3',
            Status = 'New',
            Origin = 'Phone',
            Cancellation_Reason__c = ''
        ));
        casesList.add(new Case(
            AccountId = anAccount.Id,
            Subject = 'Test Subject3',
            Status = 'Closed',
            Origin = 'Phone',
            Cancellation_Reason__c = 'Test Reason'
        ));
        insert casesList;
    }

    @isTest
    static void getOpenCasesFromAnAccount(){

        Account anAccount = [
            SELECT Id
            FROM Account
            LIMIT 1
        ];

        Test.startTest();
        List<Case> result = closeCases.getCases(anAccount.Id);
        Test.stopTest();

        System.assertEquals(3, result.size(), 'Something went wrong when getting the account cases.');
    }
    @isTest
    static void closeCasesFromAnAccountByHavingCancellationReasonAssigned(){

        Account anAccount = [
            SELECT Id
            FROM Account
            LIMIT 1
        ];
        List<Case> getCaseList = closeCases.getCases(anAccount.Id);
        getCaseList[0].Cancellation_Reason__c = 'Test Reason';
        getCaseList[1].Cancellation_Reason__c = 'Test Reason 2';

        Test.startTest();
        closeCases.updateCases(getCaseList);
        Test.stopTest();

        List<Case> result = closeCases.getCases(anAccount.Id);

        System.assertEquals(1, result.size(), 'Something went wrong when updating the account cases.');
    }
}
