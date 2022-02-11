@IsTest
public with sharing class CaseTriggerTest {
    @TestSetup
    static void makeData(){
        Case parent = new Case(
            Result__c = 'initial'
            );
        insert parent;

        Case related = new Case(
            Result__C = 'initial',
            ParentId = parent.Id
            );
        insert related;
    }
    @IsTest
    static void whenARelatedCaseIsUpdatedUpdateCurrentCase() {
        
        Case parent = [
            SELECT Id, Result__c
            FROM Case
            WHERE ParentId = NULL
            LIMIT 1
        ];

        String result = 'new result';
        parent.result__c = result;

        Test.startTest();
        Database.SaveResult updateResult = Database.update(parent);
        Test.stopTest();

        System.assert(updateResult.isSuccess(),'The result was not updated.');

        Case related  = [
            SELECT Id,ParentId,Result__c
            FROM Case
            WHERE ParentId = :parent.Id
            LIMIT 1];

        System.assertEquals(related.Result__c, result,'The related case did not update.');
    }


    @IsTest
    static void whenARelatedCaseIsUpdatedUpdateCurrentCaseBlankField() {
        
        Case parent = [
            SELECT Id, Result__c
            FROM Case
            WHERE ParentId = NULL
            LIMIT 1
        ];

        String result = ' ';
        parent.result__c = result;

        Test.startTest();
        Database.SaveResult updateResult = Database.update(parent);
        Test.stopTest();

        System.assert(updateResult.isSuccess(),'The result was not updated.');

        Case related  = [
            SELECT Id,ParentId,Result__c
            FROM Case
            WHERE ParentId = :parent.Id
            LIMIT 1];

        System.assertEquals(related.Result__c, null,'The related case did not update.');
    }
}