@isTest
public with sharing class AccountManageTest {
    @TestSetup
    static void makeData(){
        Account testAccount= new Account(Name='examplename',NumberOfEmployees=400, IdentificationType__c='NIT',DocumentNumber__c='45554477');
        insert testAccount;
    }

    @isTest
    static void AnOppotunityIsCreatedWithSuccess(){
        Id accountId=AccountManage.createAccount('examplename',200,'NIT','46000000');
        System.assert(accountId!=null);

        Account account=[select Id,Name from Account where Id=:accountId];
        System.assertEquals('examplename',account.Name,'The inserted account does not math with expected name');
    }

    @isTest
    static void shouldDeleteAccount(){
        Boolean result=AccountManage.deleteAccount('NIT','45554477');
        System.assert(result,'the account was not deleted');
    }

    @isTest
    static void shouldUpdateAccount(){
        Boolean result=AccountManage.updateAccount('modified', 130  ,'NIT','45554477');
        System.assert(result,'the account was not updated');
    }

    @isTest
    static void shouldFindAnAccountByDocumentTypeIdentityDocument(){
        Account foundAccount=AccountManage.consultAccount('NIT','45554477');
        System.assertEquals('examplename',foundAccount.Name,'Accoount found name does not match with expected name');
    }
    /*
    Create a test class called AccountManageTest and add a test to validate the createOpportunity function in the AccountManage class create an opportunity for the accounts are received through the parameter
    */
    
}