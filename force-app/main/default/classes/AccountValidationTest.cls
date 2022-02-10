@isTest
public with sharing class AccountValidationTest {
    @TestSetup
    static void makeData(){
        List<Account> existingAccounts=new List<Account>{
            new Account(Name='name1', DocumentNumber__c='46000001',IdentificationType__c='NIT'),
            new Account(Name='name2', DocumentNumber__c='46000002',IdentificationType__c='NIT'),
            new Account(Name='name3', DocumentNumber__c='46000003',IdentificationType__c='NIT'),
            new Account(Name='name4', DocumentNumber__c='46000004',IdentificationType__c='NIT'),
            new Account(Name='name5', DocumentNumber__c='46000005',IdentificationType__c='NIT'),
            new Account(Name='name6', DocumentNumber__c='46000006',IdentificationType__c='NIT')
        };
        insert existingAccounts;
    } 

    @isTest
    static void whenAnAccountIsInsertedWithANewDocumentNumberDocumentTypeShouldBeSuccess(){
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='examplename100', DocumentNumber__c='34333342',IdentificationType__c='NIT'));
        
        Test.startTest();
        Database.SaveResult[] results = Database.insert(accounts,false);
        Test.stopTest();

        Account accountToValidate=[select DocumentNumber__c from Account where DocumentNumber__c='34333342'];

        System.assertEquals('34333342',accountToValidate.DocumentNumber__c);

        for (Database.SaveResult result :results) {
            System.assert(result.success==true,'insert have to be successfull');
        }
    }

    @isTest
    static void whenAnAccountInInsertedWithAExistingDocumentNumberDocumentTypeShouldNotBeInseted(){
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='examplename100', DocumentNumber__c='46000001',IdentificationType__c='NIT'));

        Test.startTest();
        Database.SaveResult[] results= Database.insert(accounts,false);
        Test.stopTest();

        for (Database.SaveResult result :results) {
            System.assert(result.success==false,'insert have to be false');
        }
    }

    @isTest
    static void whenAnAccountIsUpdatedWithANewDocumentNumberDocumentTypeShouldBeSuccess(){
        List<Account> accounts = new List<Account>();
        Account accountToUpdate=[select Name,IdentificationType__c,DocumentNumber__c from Account where DocumentNumber__c='46000002'];
        accountToUpdate.DocumentNumber__c='46010004';
        accounts.add(accountToUpdate);
        
        Test.startTest();
        Database.SaveResult[] results = Database.update(accounts,false);
        Test.stopTest();

        Account accountToValidate=[select DocumentNumber__c from Account where DocumentNumber__c='46010004'];

        System.assertEquals('46010004',accountToValidate.DocumentNumber__c);

        for (Database.SaveResult result :results) {
            System.assert(result.success==true,'update have to be successfull');
        }
    }

    @isTest
    static void whenAccountIsUpdatedWithAnExistingDocumentTypeDocumentNumberShouldNotBeUpdated(){
        List<Account> accounts = new List<Account>();
        Account accountToUpdate=[select Name,IdentificationType__c,DocumentNumber__c from Account where DocumentNumber__c='46000002'];
        accountToUpdate.DocumentNumber__c='46000004';
        accounts.add(accountToUpdate);
        
        Test.startTest();
        Database.SaveResult[] results = Database.update(accounts,false);
        Test.stopTest();

        for (Database.SaveResult result :results) {
            System.assert(result.success==false,'updated have to be false');
        }
    }
}
