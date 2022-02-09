@isTest
public with sharing class TriggerExercise2Test {
    @TestSetup
    static void makeData(){
        Case parentCase=new Case();
        insert parentCase;

        Case aCase=new Case(
            Result__c='value',
            ParentId=parentCase.Id,
            Subject='examplesubject'
        );
        insert aCase;

    }

    @isTest
    static void whenACaseIsAsociatedWithAParentCaseResultValueIsCopiedToParentCaseResultValue(){

        Case aCase=[select Id,ParentId from Case where Subject='examplesubject'];
        aCase.Subject='subjet modified';

        Test.startTest();
        update aCase;
        Test.stopTest();

        Case parentCase=[select Id,Result__c from Case where Id=:aCase.ParentId];
        System.assertEquals(parentCase.Result__c,'value');
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

        Case parentCase=[select Id,Result__c from Case where Id=:aCase.ParentId];
        System.assertEquals(parentCase.Result__c,null);
    }
}