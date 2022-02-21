@isTest
public with sharing class AccountWithCasesControllerTest {

    @TestSetup
    private static void makedata(){
        Account anAccount = new Account(
            Name = 'Test Account'
        );
        insert anAccount;

        List<Case> caseList = new List<Case>();
        Case aCase1 = new Case(
            Subject = 'Test Case1',
            Status = 'New',
            Origin = 'Phone',
            Closing_Reason__c = 'Some Reason',
            AccountId = anAccount.Id
        );
        caseList.add(aCase1);

        Case aCase2 = new Case(
            Subject = 'Test Case2',
            Status = 'New',
            Origin = 'Phone',
            Closing_Reason__c = 'Some Reason',
            AccountId = anAccount.Id
        );
        caseList.add(aCase2);
        insert caseList;
    }
    @isTest
    private static void getCasesTest(){
       
        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'Test Account'
        ];

        Test.startTest();
        List<Case>testCaseList = AccountWithCasesController.getCases(anAccount.Id);
        Test.stopTest();

        System.assertEquals(2, testCaseList.size(), 'The list does not have the expected amount of cases that the method should return');
    }

    private static void updateCasesTest(){
       
        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'Test Account'
        ];

        List<Case> caseList = [
            SELECT Closing_Reason__c
            FROM Case
            WHERE AccountId = :anAccount.Id
        ];

        Test.startTest();
        AccountWithCasesController.updateCases(caseList);
        Test.stopTest();

        System.assertEquals(2, caseList.size(), 'The list does not have the expected amount of cases that the method should return');
        for(Case aCase : caseList){
            System.assertEquals('Closed', aCase.Status, 'A case status was not "Closed" like intended');
        }
    }
}
