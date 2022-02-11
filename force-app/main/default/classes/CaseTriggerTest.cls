@isTest
public with sharing class CaseTriggerTest {
    @TestSetup
    static void makeData(){

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

    @isTest
    static void whenInsertTwoAssociatedCasesUpdateResultOnChildCaseWithParentResult(){
        Case aParentCase = new Case(
            Result__c = 'Original Result'
        );
        
        insert aParentCase;
        
        Case aChildCase = new Case(
            ParentId = aParentCase.Id
        );
        
        insert aChildCase;  
        
        String resultChanged = 'Result Changed by Trigger';
        aParentCase.Result__c = resultChanged;

        Test.startTest();
        update aParentCase;
        Test.stopTest();

        System.assertEquals(resultChanged, aChildCase.Result__c, 'The Result of Child Case was updated by Parent Case');



    }
}