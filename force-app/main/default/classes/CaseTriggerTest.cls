@isTest 
public with sharing class CaseTriggerTest {
    public CaseTriggerTest() {

    }

    @TestSetup
    static void makeData(){
        Contact aContact = new Contact(
            FirstName = 'Darwin',
            LastName = 'Villamil',
            Email = 'dvilla1000.ds@gmail.com'
        );
        Insert(aContact);

        Task aTask = new Task(
            WhoId = aContact.Id,
            Subject = 'Call',
            Status = 'Not Started'
        );

        Insert(aTask);
    }

    @isTest
    static void whenInsertANewCaseFromContactWithACallRealatedThisCaseRelatedWithTheTask()
    {
        Contact aContact = [
            SELECT Id, Email
            FROM Contact
            WHERE Email = 'dvilla1000.ds@gmail.com'
            LIMIT 1
        ];

        Task aTask = [
            SELECT Id, WhoId
            FROM Task
            WHERE WhoId = :aContact.Id
        ];

        Datatime aDate = Datatime.now().addMinutes(-1);
        Test.setCreatedDate(aTask.Id, aDate);

        Case aCase = new Case(ContactId = aContact.Id);

        Test.startTest();
        insert aCase;
        Test.stopTest();

        Task aTaskToCompare = [
            SELECT WhatId, WhoId 
            FROM Task 
            WHERE WhoId = :aContact.Id];

        System.assertEquals(aCase.Id, aTaskToCompare.WhatId, 'The Ids not match');
    }

    @IsTest
    static void whenInsertANewCaseFromContactWithACallRealatedButThisIsCreatedSinceFourMinutesAgoThisCaseDontRelatedWithTheTask(){
        
        Contact aContact = [
            SELECT Id
            FROM Contact
            WHERE Email = 'dvilla1000.ds@gmail.com'
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
