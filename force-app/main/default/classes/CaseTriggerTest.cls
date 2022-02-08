@isTest
public with sharing class CaseTriggerTest {
    @IsTest
    static void whenHavingTwoAssociatedCasesTheResultFieldUpdatesInTheFirstCase(){
        Case aCaseParent = new Case(Subject = 'Parent Case Test',
                                    Result__c='Yes Sir');
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
}