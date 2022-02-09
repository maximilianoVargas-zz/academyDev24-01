@isTest
public with sharing class CaseTriggerTest {
    
    @TestSetup
    static void makeData(){
        Account anAccount = new Account(Name = 'TestAccount');
        insert anAccount;
        Case aCase = new Case(AccountId = anAccount.Id, Origin = 'Web');
        insert aCase;
        Case aRelationCase = new Case(AccountId = anAccount.Id, Origin = 'Web', ParentId = aCase.Id);
        insert aRelationCase;

        Contact aContact = new Contact(
            FirstName = 'Maximiliano',
            LastName = 'Vargas',
            Email = 'maximiliano.vargas@globant.com'
        );
        insert aContact;

        Task aTask = new Task(
            WhoId = aContact.Id,
            Subject = 'Call',
            Status = 'Not Started'
        );

        insert aTask;
    }

    @isTest
    static void whenUpdateCaseResultFieldWithACaseRelationship() {

        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'TestAccount'
            LIMIT 1
        ];

        Case aCase = [
            SELECT Id
            FROM Case
            WHERE AccountId = :anAccount.Id
            AND ParentId = null
            LIMIT 1
        ];

        Case aRelationCase = [
            SELECT Id, Result__c
            FROM Case
            WHERE AccountId = :anAccount.Id
            AND ParentId = :aCase.Id
            LIMIT 1
        ];

        aRelationCase.Result__c = 'Result Test';

        Test.startTest();
        update aRelationCase;
        Test.stopTest();

        Case aCaseToCompare = [
            SELECT Id, Result__c
            FROM Case
            WHERE AccountId = :anAccount.Id
            AND ParentId = null
            LIMIT 1
        ];

        System.assertEquals(aRelationCase.Result__c, aCaseToCompare.Result__c, 'The Result field dont match');

    }

    @isTest
    static void whenNoUpdateCaseResultFieldThatFieldIsNull() {

        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'TestAccount'
            LIMIT 1
        ];

        Case aCase = [
            SELECT Id
            FROM Case
            WHERE AccountId = :anAccount.Id
            AND ParentId = null
            LIMIT 1
        ];

        Case aRelationCase = [
            SELECT Id, Result__c
            FROM Case
            WHERE AccountId = :anAccount.Id
            AND ParentId = :aCase.Id
            LIMIT 1
        ];

        aRelationCase.Status = 'Working';

        Test.startTest();
        update aRelationCase;
        Test.stopTest();

        Case aCaseToCompare = [
            SELECT Id, Result__c
            FROM Case
            WHERE AccountId = :anAccount.Id
            AND ParentId = null
            LIMIT 1
        ];

        System.assertEquals(null, aCaseToCompare.Result__c, 'The Result was updated');

    }
    @IsTest
    static void whenInsertANewCaseFromContactWithACallRealatedThisCaseRelatedWithTheTask(){
        
        Contact aContact = [
            SELECT Id
            FROM Contact
            WHERE Email = 'maximiliano.vargas@globant.com'
            LIMIT 1
        ];Task aTask = [
            SELECT Id
            FROM Task
            WHERE WhoId = :aContact.Id
        ];

        Datetime aDate = Datetime.now().addMinutes(-1);
        Test.setCreatedDate(aTask.Id, aDate);

        Case aCase = new Case(
            ContactId = aContact.Id
        );

        Test.startTest();
        insert aCase;
        Test.stopTest();

        Task aTaskToCompare = [
            SELECT whatId
            FROM Task
            WHERE WhoId = :aContact.Id
        ];

        System.assertEquals(aCase.Id, aTaskToCompare.WhatId, 'The ids not match');
        
    }

    @IsTest
    static void whenInsertANewCaseFromContactWithACallRealatedButThisIsCreatedSinceFourMinutesAgoThisCaseDontRelatedWithTheTask(){
        
        Contact aContact = [
            SELECT Id
            FROM Contact
            WHERE Email = 'maximiliano.vargas@globant.com'
            LIMIT 1
        ];

        Task aTask = [
            SELECT Id
            FROM Task
            WHERE WhoId = :aContact.Id
        ];

        Datetime aDate = Datetime.now().addMinutes(-4);
        Test.setCreatedDate(aTask.Id, aDate);


        Case aCase = new Case(
            ContactId = aContact.Id
        );

        Test.startTest();
        insert aCase;
        Test.stopTest();

        Task aTaskToCompare = [
            SELECT whatId
            FROM Task
            WHERE WhoId = :aContact.Id
        ];

        System.assertNotEquals(aCase.Id, aTaskToCompare.WhatId, 'The ids match');
        
    }

}