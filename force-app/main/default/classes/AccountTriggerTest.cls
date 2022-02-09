@isTest
public with sharing class AccountTriggerTest {
    
    @TestSetup
    static void makeData(){
        // Create 2 Accounts
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 2; i++) {
            accounts.add(new Account(
                Name = 'Prueba ' + i,
                Identification_Type__c = 'NIT',
                Document_Number__c = '1234567' + i
            ));
        }
        insert accounts;
    }

    @isTest
    static void whenAccountWithSameIdentificationTypeAndDocumentNumberExists_ThenInsertFails() {
        // Create repeated account
        Account acc = new Account(
            Name = 'Prueba',
            Identification_Type__c = 'NIT',
            Document_Number__c = '1234567' + '0'
        );
        
        Test.startTest();
        Database.SaveResult result = Database.insert(acc, false);
        Test.stopTest();

        system.assert( !result.isSuccess() );
    }

    @isTest
    static void whenAccountWithUniqueIdentificationTypeAndDocumentNumberExists_ThenInsertSucceeds() {
        // Create new unique account
        Account acc = new Account(
            Name = 'Prueba',
            Identification_Type__c = 'NIT',
            Document_Number__c = '87654321'
        );
        
        Test.startTest();
        Database.SaveResult result = Database.insert(acc, false);
        Test.stopTest();

        system.assert( result.isSuccess() );
        List<Account> accounts = [
            SELECT Id
            FROM Account
            WHERE Document_Number__c = '87654321' AND Identification_Type__c = 'NIT'
        ];
        System.assert(accounts.size() == 1);
    }

    @isTest
    static void whenUpdatingAccountToUniqueIdentificationTypeAndDocumentNumber_ThenUpdateSucceeds() {
        // Retrieve an account and update it
        Account acc = [
            SELECT Id
            FROM Account
            LIMIT 1
        ];
        acc.Document_Number__c = '87654321';
        
        Test.startTest();
        Database.SaveResult result = Database.update(acc, false);
        Test.stopTest();

        system.assert( result.isSuccess() );
        List<Account> accounts = [
            SELECT Id
            FROM Account
            WHERE Document_Number__c = '87654321' AND Identification_Type__c = 'NIT'
        ];
        System.assert(accounts.size() == 1);
    }

    @isTest
    static void whenUpdatingAccountToRepeatedIdentificationTypeAndDocumentNumber_ThenUpdateFails() {
        // Retrieve an account and update it
        Account acc = [
            SELECT Id
            FROM Account
            WHERE Document_Number__c = '12345670'
        ];
        acc.Document_Number__c = '12345671';  // Repeated!
        
        Test.startTest();
        Database.SaveResult result = Database.update(acc, false);
        Test.stopTest();

        system.assert( !result.isSuccess() );
    }
}