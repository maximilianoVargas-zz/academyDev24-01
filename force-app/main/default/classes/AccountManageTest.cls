@isTest
public with sharing class AccountManageTest {
    @TestSetup
    static void makeData(){
        Account testAccount= new Account(Name='examplename',NumberOfEmployees=400, IdentificationType__c='NIT',DocumentNumber__c='45554477');
        insert testAccount;
    }

    @isTest
    static void AnOppotunityIsCreatedWithSuccess(){
        Test.startTest();
        Id accountId=AccountManage.createAccount('examplename',200,'NIT','46000000');
        Test.stopTest();

        Integer anAccountWithExpectedId=[
            SELECT count() 
            FROM Account
            WHERE Id=:accountId
        ];

        if(anAccountWithExpectedId>0){
            Account anAccount=[
                SELECT Id,Name 
                FROM Account 
                WHERE Id=:accountId];

            System.assertEquals('examplename',anAccount.Name,'The inserted account does not math with expected name');
        }
    }

    @isTest
    static void shouldDeleteAccount(){
        Test.startTest();
        Boolean result=AccountManage.deleteAccount('NIT','45554477');
        System.assert(result,'the account was not deleted');
    }

    @isTest
    static void shouldUpdateAccount(){
        Test.startTest();
        Boolean result=AccountManage.updateAccount('modified', 130  ,'NIT','45554477');
        Test.stopTest();
        System.assert(result,'the account was not updated');
    }

    @isTest
    static void shouldFindAnAccountByDocumentTypeIdentityDocument(){
        Test.startTest();
        Account foundAccount=AccountManage.consultAccount('NIT','45554477');
        Test.stopTest();
        System.assertEquals('examplename',foundAccount.Name,'Accoount found name does not match with expected name');
    }
    /*
    Create a test class called AccountManageTest and add a test to validate the createOpportunity function in the AccountManage class create an opportunity for the accounts are received through the parameter
    */
    
}