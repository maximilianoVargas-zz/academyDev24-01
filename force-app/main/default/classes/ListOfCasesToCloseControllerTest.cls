@isTest
private with sharing class ListOfCasesToCloseControllerTest {

    @TestSetup
    static void makeData(){
        insert new Account(Name = 'Pedro');
        insert new Account(Name = 'Jorge');

        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'Jorge'
        ];

        List<Case> cases = new List<Case>();
        cases.add(new Case(Status = 'New', AccountId = anAccount.Id));
        cases.add(new Case(Status = 'New', AccountId = anAccount.Id));
        cases.add(new Case(Status = 'New', AccountId = anAccount.Id));
        
        insert cases;
    }

    @isTest static void getCasesWhenThereAreNotCases(){
        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'Pedro'
            LIMIT 1
        ];
        
        test.startTest();
        List<Case> result = ListOfCasesToCloseController.getCases(anAccount.Id);
        test.stopTest();

        System.assert(result.isEmpty(), 'The list of cases for this account must be empty');
    }

    @isTest static void getCasesWhenThereAreCases(){
        
        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'Jorge'
            LIMIT 1
        ];
        
        test.startTest();
        List<Case> result = ListOfCasesToCloseController.getCases(anAccount.Id);
        test.stopTest();

        System.assert(!result.isEmpty(), 'The list of cases for this account must be not empty');
        System.assertEquals(3, result.size(), 'The number of cases for this account does not match');
    }

    @isTest static void closeCasesSuccessful(){
        
        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'Jorge'
            LIMIT 1
        ];

        List<Case> cases = [
            SELECT Id
            FROM Case
            WHERE AccountId = :anAccount.Id
        ];

        List<String> reasonsById = new List<String>();

        reasonsById.add('{"id":"' + cases[0].Id + '", "reason":"reason for case 0"}');
        reasonsById.add('{"id":"' + cases[1].Id + '", "reason":"reason for case 1"}');
               
        test.startTest();
        ListOfCasesToCloseController.closeCases(reasonsById);
        test.stopTest();

        List<Case> casesDB = [
            SELECT Id, Status, Close_reason__c
            FROM Case
            WHERE AccountId = :anAccount.Id
        ];

        Case expectedCase0 = new Case(Status='Closed', Close_reason__c='reason for case 0');
        Case expectedCase1 = new Case(Status='Closed', Close_reason__c='reason for case 1');
        Case expectedCase2 = new Case(Status='New');

        System.assert(!casesDB.isEmpty(), 'The list of cases for this account must be not empty');
        System.assertEquals(3, casesDB.size(), 'The number of cases for this account does not match');
        System.assertEquals(expectedCase0.Status, casesDB[0].Status);
        System.assertEquals(expectedCase0.Close_reason__c, casesDB[0].Close_reason__c);
        System.assertEquals(expectedCase1.Status, casesDB[1].Status);
        System.assertEquals(expectedCase1.Close_reason__c, casesDB[1].Close_reason__c);
        System.assertEquals(expectedCase2.Status, casesDB[2].Status);
        System.assertEquals(null, casesDB[2].Close_reason__c);
    }
}
