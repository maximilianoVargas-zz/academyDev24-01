@isTest
public with sharing class AccountManageTest {
    @isTest
    static void exampletest(){
        Id accountId=AccountManage.createAccount('examplename',200,'NIT','46000000');
        System.assert(accountId!=null);

        Account account=[select Id,Name from Account where Id=:accountId];
        System.assertEquals('examplename',account.Name);
    }

    /*
    Create a test class called AccountManageTest and add a test to validate the createOpportunity function in the AccountManage class create an opportunity for the accounts are received through the parameter
    */
    
}