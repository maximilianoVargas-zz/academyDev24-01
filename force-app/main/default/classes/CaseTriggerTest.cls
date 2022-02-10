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
        ];
        
        Task aTask = [
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

    @IsTest
    static void whenHavingTwoAssociatedCasesTheResultFieldUpdatesInTheFirstCase(){
        Case aCaseParent = new Case(Subject = 'Parent Case Test',
                                    Result__c='Not updated');
        insert aCaseParent;

        Case aCaseChild = new Case(Subject='Child Case Test',
                                    ParentId = aCaseParent.Id);  
        insert aCaseChild;

        aCaseChild.Result__c='Updated Value';

        Test.startTest();
        update aCaseChild;
        Test.stopTest();

        Case updatedParentCase = [SELECT Id, Result__c
                                FROM Case
                                WHERE Id = :aCaseParent.Id];

        System.assertEquals('Updated Value', updatedParentCase.Result__c, 'The associated case Result field do not match');
    }

    @IsTest
    static void whenHavingTwoAssociatedCasesTheResultFieldUpdatesBlankInTheFirstCase(){
        Case aCaseParent = new Case(Subject = 'Parent Case Test',
                                    Result__c='Not updated');
        insert aCaseParent;

        Case aCaseChild = new Case(Subject='Child Case Test',
                                    ParentId = aCaseParent.Id,
                                    Result__c= 'Something');  
        insert aCaseChild;

        aCaseChild.Result__c = null;

        Test.startTest();
        update aCaseChild;
        Test.stopTest();

        Case updatedParentCase = [SELECT Id, Result__c
                                FROM Case
                                WHERE Id = :aCaseParent.Id];

        System.assertEquals(null, updatedParentCase.Result__c, 'The associated case Result field do not match');
    }
}