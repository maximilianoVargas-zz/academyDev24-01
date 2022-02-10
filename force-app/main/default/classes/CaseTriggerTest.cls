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

        List<Case> parentCases = new List<Case>();
        List<Case> childCases  = new List<Case>();

        for(Integer i=0; i<10; i++){
            parentCases.add(new Case(Status = 'New',
                                    Result__c = 'First Value'));
        }

        insert parentCases;

        for(Case aCase : parentCases){
            Case aChildCase     = new Case();
            aChildCase.ParentId = aCase.Id;

            childCases.add(aChildCase);
        }

        insert childCases;
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
    static void whenACaseSubjectFieldIsUpdatedSoIsTheSubjectFieldInItsAssociatedCase(){

        List<Case> parentCasesToUpdate = [
                                SELECT Id, Result__c
                                FROM Case
                                WHERE Result__c = 'First Value'
                                ];

        for(Case aCase : parentCasesToUpdate){
            aCase.Result__c = 'Modified field.';
        }

        Test.startTest();
        update parentCasesToUpdate;
        Test.stopTest();

        List<String> parentCasesIds = new List<String>();

        for(Case aCase : parentCasesToUpdate){
            String aParentCaseId = aCase.Id;
            parentCasesIds.add(aParentCaseId);
        }

        List<Case> updatedChildCases = [
                                    SELECT Id, Result__c
                                    FROM Case
                                    WHERE ParentId IN :parentCasesIds
                                    ];

        System.assertEquals('Modified field.', updatedChildCases.get(0).Result__c, 'The Result field in the child case was not modified when the same field was modified in the parent case.');
    }

    @isTest
    static void whenACaseSubjectFieldIsUpdatedToBlankSoIsTheSubjectFieldInItsAssociatedCase(){

        List<Case> parentCasesToUpdate = [
                                        SELECT Id, Result__c
                                        FROM Case
                                        WHERE Result__c = 'First Value'
                                        ];

        for(Case aCase : parentCasesToUpdate){
        aCase.Result__c = null;
        }

        Test.startTest();
        update parentCasesToUpdate;
        Test.stopTest();

        List<String> parentCasesIds = new List<String>();

        for(Case aCase : parentCasesToUpdate){
        String aParentCaseId = aCase.Id;
        parentCasesIds.add(aParentCaseId);
        }

        List<Case> updatedChildCases = [
                                    SELECT Id, Result__c
                                    FROM Case
                                    WHERE ParentId IN :parentCasesIds
                                    ];

        Boolean aChildCaseResultField = String.isBlank(updatedChildCases.get(0).Result__c);

         System.assertEquals(true, aChildCaseResultField, 'The result field in the child Case was nos updated to blank when its parent result field was.');
    }
}