@isTest
public with sharing class CaseTriggerTest {
    @TestSetup
    static void makeData(){
        Contact aContact = new Contact(
            FirstName = 'examplename',
            LastName = 'examplelastname',
            Email = 'examplename@globant.com'
        );
        insert aContact;

        Task aTask = new Task(
            WhoId = aContact.Id,
            Subject = 'Call',
            Status = 'Not Started'
        );

        insert aTask;

        Case parentCase=new Case();
        insert parentCase;

        Case aCase=new Case(
            Result__c='value',
            ParentId=parentCase.Id,
            Subject='examplesubject'
        );
        insert aCase;
    }
    //- Seleccionar todas las tareas que tengan un what id nulo y whoid esten relacionadas con el id de contacto relacionado con algun caso y fecha de creacion de la tare sea mayor en dos minutos a la fecha actual

    @IsTest
    static void whenInsertedANewCaseFromContactWithATaskRelatedThisCaseRelatedWithTheTask(){
        Contact aContact=[
            SELECT Id 
            FROM Contact 
            WHERE Email='examplename@globant.com'
        ];
        Task aTask=[select Id from Task where whoId=:aContact.Id];

        DateTime aDate=Datetime.now().addMinutes(-1);
        Test.setCreatedDate(aTask.Id,aDate);

        Case aCase=new Case(
            ContactId=aContact.Id
        );

        Test.startTest();
        insert aCase;
        Test.stopTest();

        Task aTaskToCompare =[select WhatId from Task where whoId=:aContact.Id];

        System.assertEquals(aCase.Id,aTaskToCompare.WhatId);

    }

    @isTest
    static void whenInsertedANewCaseFromContactWithCallRelatedButThisIsCreatedSinceFourMinutesAgoThisCaseDontRelatedWithTheTask(){
        Contact aContact=[select Id From Contact where Email='examplename@globant.com'];
        Task aTask=[select Id from Task where whoId=:aContact.Id];

        Datetime aDate = Datetime.now().addMinutes(-4);
        Test.setCreatedDate(aTask.Id, aDate);

        Case aCase = new Case(
            ContactId = aContact.Id
        );

        Test.startTest();
        insert aCase;
        Test.stopTest();

        Task aTaskToCompare = [select whatId from Task where WhoId = :aContact.Id];

        System.assertNotEquals(aCase.Id, aTaskToCompare.WhatId);


    }
        
    @isTest
    static void whenACaseIsAsociatedWithAParentCaseResultValueIsCopiedToParentCaseResultValue(){

        Case aCase=[
            SELECT Id,ParentId 
            FROM Case 
            WHERE Subject='examplesubject'
        ];
        aCase.Subject='subjet modified';

        Test.startTest();
        update aCase;
        Test.stopTest();

        Case parentCase=[
            SELECT Id,Result__c 
            FROM Case 
            WHERE Id=:aCase.ParentId
        ];
        System.assertEquals(parentCase.Result__c,'value','parent case value does not match with expected');
    }

    /*
    */
    @isTest
    static void whenACaseIsUpsatedWithBlankValueParentCaseResultValuesIsUpdatedToBlank(){
        Case aCase=[select Id,Result__c,ParentId from Case where Subject='examplesubject'];
        aCase.Result__c='';
        
        Test.startTest();
        update aCase;
        Test.stopTest();

        Case parentCase=[
            SELECT Id,Result__c 
            FROM Case where Id=:aCase.ParentId
        ];
        System.assertEquals(parentCase.Result__c,null,'parent case values does not mathc with expected');
    }


}