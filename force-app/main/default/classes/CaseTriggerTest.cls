@isTest
public with sharing class CaseTriggerTest {
    @TestSetup
    static void makeData(){

        Contact aContact = new Contact(
            FirstName = 'Gerardo',
            LastName = 'Seoane',
            Email = 'gerardo.seoane@globant.com'
        );
        insert aContact;

        Task aTask = new Task(
            WhoId = aContact.Id,
            Subject = 'Call',
            Status = 'Not Started'
        );

        insert aTask;

        Case aCase=new Case();
        aCase.Subject='Caso Padre';
        insert aCase;

        Case aCase2=new Case();
        aCase2.Subject='Caso Hijo';
        aCase2.Result__c='Test';
        aCase2.ParentId=aCase.Id;
        insert aCase2;
    }

    @IsTest
    static void whenInsertANewCaseFromContactWithACallRealatedThisCaseRelatedWithTheTask(){
        
        Contact aContact = [
            SELECT Id
            FROM Contact
            WHERE Email = 'gerardo.seoane@globant.com'
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
            WHERE Email = 'gerardo.seoane@globant.com'
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

    @isTest static void UpdatePrincipalCaseWhenReleatedCaseIsUpdated(){

        Case aCase=[
            SELECT Result__c
            FROM Case
            where Subject='Caso Hijo'
        ];

        aCase.Result__c='Test Updated';

        Test.startTest();
        Update aCase;
        Test.stopTest();

        Case aPrincipalCase=[
            SELECT Result__c
            FROM Case
            where Subject='Caso Padre'
        ];

        Case aReleatedCase=[
            SELECT Result__c
            FROM Case
            where Subject='Caso Hijo'
        ];

        System.assertEquals(aPrincipalCase.Result__c,aReleatedCase.Result__c);
    }

    @isTest static void UpdatePrincipalCaseWhenReleatedCaseIsUpdatedWithEmptyValue(){

        Case aCase=[
            SELECT Result__c
            FROM Case
            where Subject='Caso Hijo'
        ];

        aCase.Result__c=null;

        Test.startTest();
        Update aCase;
        Test.stopTest();

        Case aPrincipalCase=[
            SELECT Result__c
            FROM Case
            where Subject='Caso Padre'
        ];

        Case aReleatedCase=[
            SELECT Result__c
            FROM Case
            where Subject='Caso Hijo'
        ];

        System.assertEquals(aPrincipalCase.Result__c,null);
    }
}