@isTest
public class CaseTriggerTest {

    @TestSetup
    static void makeData(){
        Contact aContact = new Contact(FirstName='Test', LastName='Subject', Email='tsubject@mail.com');
        insert aContact;

        Task aTask = new Task(WhoId=aContact.Id, Subject='Call', Status='Not Started');
        insert aTask;

        Case firstCase = new Case(ContactId=aContact.Id, ParentId=null, Result__c='Default');
        insert firstCase;

        Case secondCase = new Case(ContactId=aContact.Id, ParentId=firstCase.Id, Result__c='Default');
        insert secondCase;
    }

    @isTest static void shouldAssignCaseToUnrelatedTaskThatsUnderTwoMinutes(){
        
        Contact aContact = [SELECT Id, Name FROM Contact WHERE Email='tsubject@mail.com'];
        Task aTask = [SELECT Id FROM Task WHERE WhoId=:aContact.Id];

        Datetime aDate = Datetime.now().addMinutes(-1);
        Test.setCreatedDate(aTask.Id, aDate);

        Case aCase = new Case(ContactId=aContact.Id);

        Test.startTest();
        insert aCase;
        Test.stopTest();

        Task taskToCheckRelation = [SELECT WhatId FROM Task WHERE WhoId=:aContact.Id];

        System.assertEquals(aCase.Id, taskToCheckRelation.WhatId, 'Something went wrong');
    }

    @isTest static void shouldNotAssignCaseToTaskSinceItsBeenOverFourMinutes(){
        Contact aContact = [SELECT Id, Name FROM Contact WHERE Email='tsubject@mail.com'];
        Task aTask = [SELECT Id FROM Task WHERE WhoId=:aContact.Id];

        Datetime aDate = Datetime.now().addMinutes(-5);
        Test.setCreatedDate(aTask.Id, aDate);

        Case aCase = new Case(ContactId=aContact.Id);

        Test.startTest();
        insert aCase;
        Test.stopTest();

        Task taskToCheckRelation = [SELECT WhatId FROM Task WHERE WhoId=:aContact.Id];

        System.assertNotEquals(aCase.Id, taskToCheckRelation.WhatId, 'Something went wrong');
    }

    @isTest static void shouldUpdateResultFieldFromAssociatedCase(){
        Contact aContact = [SELECT Id FROM Contact WHERE Email='tsubject@mail.com'];
        Case firstCase = [SELECT Id FROM Case WHERE ContactId=:aContact.Id AND ParentId=null];
        Case secondCase = [SELECT Id, Result__c FROM Case WHERE ContactId=:aContact.Id AND ParentId=:firstCase.Id];

        secondCase.Result__c = 'A Result';

        Test.startTest();
        update secondCase;
        Test.stopTest();

        Case caseToCheckRelation = [SELECT Id, Result__c FROM Case WHERE ContactId=:aContact.Id AND ParentId=null];

        System.assertEquals(secondCase.Result__c, caseToCheckRelation.Result__c, 'Something went wrong');
    }

    @isTest static void shouldUpdateResultFieldFromAssociatedCaseIfLeftBlank(){
        Contact aContact = [SELECT Id FROM Contact WHERE Email='tsubject@mail.com'];
        Case firstCase = [SELECT Id FROM Case WHERE ContactId=:aContact.Id AND ParentId=null];
        Case secondCase = [SELECT Id, Result__c FROM Case WHERE ContactId=:aContact.Id AND ParentId=:firstCase.Id];

        secondCase.Result__c = '';

        Test.startTest();
        update secondCase;
        Test.stopTest();

        Case caseToCheckRelation = [SELECT Id, Result__c FROM Case WHERE ContactId=:aContact.Id AND ParentId=null];

        System.assertEquals(null, caseToCheckRelation.Result__c, 'Something went wrong');
    }
}
