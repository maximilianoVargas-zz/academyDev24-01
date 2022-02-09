@isTest
public with sharing class CaseTriggerTest {

    @TestSetup
    static void makeData(){

        Case aCase1 = new Case(Result__c = 'Not edited');
        Case aCase2 = new Case(Result__c = 'Not edited');

        
        List<Case> cases = new List<Case>();
        cases.add(aCase1);
        cases.add(aCase2);
        
        insert cases;

        aCase1.ParentId = aCase2.Id;

        update cases;
    }   


   @isTest static void updateAssociatedCasesWhenResultChanges(){
       List<Case> listCases = [
           SELECT Id, Result__c
           FROM Case
       ];

       listCases.get(0).Result__c = 'edited';

       Test.startTest();
       update listCases;
       Test.stopTest();

       List<Case> listCasesEdited = [
           SELECT Id, Result__c
           FROM Case
       ];


       System.assertEquals('edited', listCasesEdited.get(0).Result__c, 'The first case result does not changed');
       System.assertEquals('edited', listCasesEdited.get(1).Result__c, 'The associated case result does not changed');
   }

   @isTest static void updateAssociatedCasesWhenResultIsBlanck(){
    List<Case> listCases = [
        SELECT Id, Result__c
        FROM Case
    ];

    listCases.get(0).Result__c = null;

    Test.startTest();
    update listCases;
    Test.stopTest();

    List<Case> listCasesEdited = [
        SELECT Id, Result__c
        FROM Case
    ];

    System.assertEquals(null, listCasesEdited.get(0).Result__c, 'The first case result is not blank');
    System.assertEquals(null, listCasesEdited.get(1).Result__c, 'The associated case result is not blanck');
   }
}