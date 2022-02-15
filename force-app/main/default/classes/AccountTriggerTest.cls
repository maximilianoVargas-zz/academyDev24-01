@isTest
public with sharing class AccountTriggerTest {
    @TestSetup
    static void makeData(){
        List<Account> accounts= new List<Account>();

        for (Integer i = 0; i < 20; i++) {
            accounts.add(new Account(Name = 'Test Account' + i,
                                     Document_number__c = '0' + i,
                                     Identification_type__c = 'NIT'));
        }
        insert accounts;
    }

    @isTest
    static void throwExceptionWhenAccountsAreInsertedAndThereIsAnExistingAccountWithTheSameDocumentNumberAndIdType(){

        List<Account> accountsToInsert = new List<Account>();

        for (Integer i = 0; i < 20; i++) {
            accountsToInsert.add(new Account(Name = 'Test Account To Insert' + i,
                                     Document_number__c = '0' + i,
                                     Identification_type__c = 'NIT'));
        }
        
        Test.startTest();
        Database.insert(accountsToInsert, false);
        Test.stopTest();

        List<Account> existingNIPAccounts = [
            SELECT Id
            FROM   Account
            WHERE  Name LIKE 'Test Account%'
                AND Document_number__c LIKE '0%'
                AND Identification_type__c = 'NIT'
        ];

        System.assertEquals(20, existingNIPAccounts.size(), 'The error was not thrown and the accounts were inserted anyways.');
    }

    @isTest
    static void throwExceptionWhenAccountsAreUpdatedAndThereIsAnExistingAccountWithTheSameDocumentNumberAndIdType(){

        List<Account> accountsToUpdate = [
                                         SELECT Id, Name, Document_number__c, Identification_type__c
                                         FROM   Account
                                         WHERE  Name LIKE 'Test Account%'
                                            AND Document_number__c LIKE '0%'
                                            AND Identification_type__c = 'NIT' 
                                         ];
        
        for(Account anAccount : accountsToUpdate){
            anAccount.Name = 'Test Account Modified';
        }
        Test.startTest();
        Database.update(accountsToUpdate, false);
        Test.stopTest();

        List<Account> existingAccounts = [
                                         SELECT Id
                                         FROM   Account
                                         WHERE  Name = 'Test Account Modified'
                                            AND Document_number__c LIKE '0%'
                                            AND Identification_type__c = 'NIT'
                                         ];

        System.assertEquals(20, existingAccounts.size(), 'The error was not thrown and the accounts were updated anyways.');
    }
}