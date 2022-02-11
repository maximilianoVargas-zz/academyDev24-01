@isTest
public with sharing class CaseTriggerTest2 {

    @TestSetup
    static void InsertData(){

        Case aCase=new Case();
        aCase.Subject='Caso Padre';
        insert aCase;

        Case aCase2=new Case();
        aCase2.Subject='Caso Hijo';
        aCase2.Result__c='Test';
        aCase2.ParentId=aCase.Id;
        insert aCase2;
    }

    @isTest static void UpdatePrincipalCaseWhenReleatedCaseIsUpdated(){

        Case aCase=[
            SELECT Result__c
            FROM Case
            where Subject='Caso Hijo'
        ];

        aCase.Result__c='Test Updated';

        Test.startTest();
        Update aCase;
        Test.stopTest();

        Case aPrincipalCase=[
            SELECT Result__c
            FROM Case
            where Subject='Caso Padre'
        ];

        Case aReleatedCase=[
            SELECT Result__c
            FROM Case
            where Subject='Caso Hijo'
        ];

        System.assertEquals(aPrincipalCase.Result__c,aReleatedCase.Result__c);
    }

    @isTest static void UpdatePrincipalCaseWhenReleatedCaseIsUpdatedWithEmptyValue(){

        Case aCase=[
            SELECT Result__c
            FROM Case
            where Subject='Caso Hijo'
        ];

        aCase.Result__c=null;

        Test.startTest();
        Update aCase;
        Test.stopTest();

        Case aPrincipalCase=[
            SELECT Result__c
            FROM Case
            where Subject='Caso Padre'
        ];

        Case aReleatedCase=[
            SELECT Result__c
            FROM Case
            where Subject='Caso Hijo'
        ];

        System.assertEquals(null,aReleatedCase.Result__c);
    }
    
}
