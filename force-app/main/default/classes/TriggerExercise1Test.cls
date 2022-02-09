@isTest
public with sharing class TriggerExercise1Test {
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
    }
    //- Seleccionar todas las tareas que tengan un what id nulo y whoid esten relacionadas con el id de contacto relacionado con algun caso y fecha de creacion de la tare sea mayor en dos minutos a la fecha actual

    @IsTest
    static void whenInsertedANewCaseFromContactWithATaskRelatedThisCaseRelatedWithTheTask(){
        Contact aContact=[select Id from Contact where Email='examplename@globant.com'];
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
        


}
/*
*/