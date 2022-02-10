@IsTest
public with sharing class CaseTriggerTest {

    @TestSetup
    static void makeData(){
        Contact aContact = new Contact(
            FirstName = 'Julian',
            LastName = 'Ibarra');
        insert aContact;
    }

    @IsTest
    public static void whenCreateCaseAndExistsTaskCreatedTwoMinutesBeforeShouldRelatedToCase() {

        Contact aContact = [
            Select Id 
            From Contact 
            Where LastName = 'Ibarra'
        ];

        Task aTask = new Task(
            WhoId = aContact.Id, 
            Subject = 'Call');
        insert aTask;
            
        Test.startTest();
        Case aCase = new Case(ContactId = aContact.Id);
        insert aCase;
        Test.stopTest();
        
        List<Task> tasks = [
            Select Id, WhatId 
            From Task 
            Where WhoId = :aContact.Id
        ];

        System.assertEquals(aCase.Id, tasks.get(0).WhatId, 'Should be a task related to case');
    }

    @IsTest
    public static void whenCreateCaseAndExistsTaskCreateFourMinutesBeforeShouldNotRelatedToCase() {

        Contact aContact = [
            Select Id 
            From Contact 
            Where LastName = 'Ibarra'
        ];

        Task aTask = new Task(
            WhoId = aContact.Id, 
            Subject = 'Call');
        insert aTask;
        Test.setCreatedDate(aTask.Id, DateTime.now().addMinutes(-4));

        Test.startTest(); 
        Case aCase = new Case(ContactId = aContact.Id);
        insert aCase;        
        Test.stopTest();

        List<Task> tasks = [
            Select Id, WhatId 
            From Task 
            Where WhoId = :aContact.Id
        ];
     
        System.assertNotEquals(aCase.Id, tasks.get(0).WhatId, 'Should not be a task related to case');
       
    }

    @IsTest
    public static void whenModifyFieldResultShouldModifyResultInAssocitedCases() {

        Case aCase = new Case(Status = 'New');
        Case childCase = new Case(Status = 'New');
        insert aCase;
        childCase.ParentId = aCase.Id;
        insert childCase;

        Test.startTest();
        aCase.Result__c = 'Updated';
        update aCase;
        Test.stopTest();

        Case caseResult = [
            Select Id, Result__c 
            From Case 
            Where Id = :childCase.Id
        ];

        System.assertEquals(aCase.Result__c, caseResult.Result__c, 'Should update field Result__c in childCase');

    }

    @IsTest
    public static void whenModifyFieldResultBlankShouldModifyResultInAssocitedCases() {

        Case aCase = new Case(
            Status = 'New', 
            Result__c = 'Parent Created');
        Case childCase = new Case(
            Status = 'New', 
            Result__c = 'Child Created');

        insert aCase;
        childCase.ParentId = aCase.Id;
        insert childCase;

        Test.startTest();
        aCase.Result__c = null;
        update aCase;
        Test.stopTest();

        Case caseResult = [
            Select Id, Result__c 
            From Case 
            Where Id = :childCase.Id
        ];

        System.assertEquals(aCase.Result__c, caseResult.Result__c, 'Should update field Result__c in childCase');

    }
}