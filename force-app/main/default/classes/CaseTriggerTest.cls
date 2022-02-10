@isTest
public with sharing class CaseTriggerTest {

    private static final Integer NUMBER_OF_CASES = 10;

    @TestSetup
    static void makeData(){
        Contact aContact = new Contact(
            FirstName = 'ignacio',
            LastName = 'mendez',
            Email = 'ignacio.mendez@globant.com'
        );
        insert aContact;

        Task aTask = new Task(
            WhoId = aContact.Id,
            Subject = 'Call',
            Status = 'Not Started'
        );
        insert aTask;

        // Create parent cases
        List<Case> parentCases = new List<Case>();
        for (Integer i = 0; i < NUMBER_OF_CASES; i++) {
            parentCases.add(
                new Case(
                    Description = EncodingUtil.base64encode(Crypto.generateAesKey(192)).substring(0, 10)
                )
            );
        }
        insert parentCases;

        // Create child cases
        List<Case> childCases = new List<Case>();
        for (Integer i = 0; i < NUMBER_OF_CASES; i++) {
            childCases.add(
                new Case(
                    Description = EncodingUtil.base64encode(Crypto.generateAesKey(192)).substring(0, 10),
                    ParentId = parentCases.get(i).Id,
                    Result__c = 'Data'
                )
            );
        }
        insert childCases;
    }
    
    @isTest
    public static void whenCaseIsCreated_IfUnassignedTaskWithCreationDateLessThanTwoMinutesExist_ThenCaseIsAssignedToTask() {
        Contact aContact = [
            SELECT Id
            FROM Contact
            WHERE Email = 'ignacio.mendez@globant.com'
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

        System.assertEquals(aCase.Id, aTaskToCompare.WhatId, 'The ids don`t match');
    }

    @isTest
    public static void whenCaseIsCreated_IfUnassignedTaskWithCreationDateMoreThanTwoMinutesExist_ThenNothingHappens() {
        Contact aContact = [
            SELECT Id
            FROM Contact
            WHERE Email = 'ignacio.mendez@globant.com'
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
    public static void whenCaseResultFieldIsUpdated_ThenParentCaseIsAlsoUpdated() {
        List<Case> childCases = [
            SELECT Id, Result__c
            FROM Case
            WHERE ParentId != NULL
        ];
        
        // Prepare to update
        for (Case childCase : childCases) {
            childCase.Result__c = 'I changed';
        }

        Test.startTest();
        update childCases;
        Test.stopTest();

        // Assertions
        List<Case> parentCases = [
            SELECT Id, Result__c
            FROM Case
            WHERE ParentId = NULL
        ];
        for (Case parentCase : parentCases) {
            System.assertEquals('I changed', parentCase.Result__c, 'The parent Result__c field must have changed');
        }
        for (Case childCase : [SELECT Result__c FROM Case WHERE ParentId != NULL]) {
            System.assertEquals('I changed', childCase.Result__c, 'The child Result__c field must have changed');
        }
    }

    @isTest
    public static void whenCaseResultFieldIsLeftBlank_ThenParentCaseIsAlsoLeftBlank() {
        List<Case> childCases = [
            SELECT Id
            FROM Case
            WHERE ParentId != NULL
        ];
        
        // Prepare to update
        for (Case childCase : childCases) {
            childCase.Result__c = null;
        }

        Test.startTest();
        update childCases;
        Test.stopTest();

        // Assertions
        List<Case> parentCases = [
            SELECT Id, Result__c
            FROM Case
            WHERE ParentId = NULL
        ];
        for (Case parentCase : parentCases) {
            System.assertEquals(null, parentCase.Result__c, 'The parent Result__c field must have changed');
        }
        for (Case childCase : [SELECT Result__c FROM Case WHERE ParentId != NULL]) {
            System.assertEquals(null, childCase.Result__c, 'The child Result__c field must have changed');
        }
    }
}