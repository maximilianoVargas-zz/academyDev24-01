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
    static void whenAccountWithSameIdentificationTypeAndDocumentNumberExistsThenInsertFails() {
        // Create repeated accounts
        List<Account> repeatedAccounts = new List<Account>();
        repeatedAccounts.add(new Account(
            Name = 'Prueba',
            Identification_Type__c = 'NIT',
            Document_Number__c = '1234567' + '0'
        ));
        repeatedAccounts.add(new Account(
            Name = 'Prueba',
            Identification_Type__c = 'NIT',
            Document_Number__c = '1234567' + '1'
        ));
        
        Test.startTest();
        List<Database.SaveResult> results = Database.insert(repeatedAccounts, false);
        Test.stopTest();

        for(Database.SaveResult result : results) {
            system.assert(
                !result.isSuccess(),
                'The insert must fail'
            );
            system.assert(result.getErrors().size() == 1, 'Exactly 1 error must ocurr');
            system.assertEquals( 
                'Could not insert/update the account because there' +
                    'already exist accounts that have an Identification Type and Document Number',
                    result.getErrors().get(0).getMessage()
            );
        }
    }

    @isTest
    static void whenAccountWithUniqueIdentificationTypeAndDocumentNumberExistsThenInsertSucceeds() {
        // Create new unique account
        Account acc = new Account(
            Name = 'Prueba',
            Identification_Type__c = 'NIT',
            Document_Number__c = '87654321'
        );
        
        Test.startTest();
        Database.SaveResult result = Database.insert(acc, false);
        Test.stopTest();

        system.assert(result.isSuccess(), 'The insert must be successful');
        List<Account> accounts = [
            SELECT Id
            FROM Account
            WHERE Document_Number__c = '87654321' AND Identification_Type__c = 'NIT'
        ];
        System.assert(accounts.size() == 1, 'The account must have been created');
    }

    @isTest
    static void whenUpdatingAccountToUniqueIdentificationTypeAndDocumentNumberThenUpdateSucceeds() {
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

        system.assert(result.isSuccess(), 'The update must be successful');
        List<Account> accounts = [
            SELECT Id
            FROM Account
            WHERE Document_Number__c = '87654321' AND Identification_Type__c = 'NIT'
        ];
        System.assert(accounts.size() == 1, 'The account must have been updated');
    }

    @isTest
    static void whenUpdatingAccountToRepeatedIdentificationTypeAndDocumentNumberThenUpdateFails() {
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

        system.assert(!result.isSuccess(), 'The update must fail');
        system.assert( result.getErrors().size() == 1, 'Exactly 1 error must ocurr');
        system.assertEquals( 
            'Could not insert/update the account because there' +
                'already exist accounts that have an Identification Type and Document Number',
            result.getErrors().get(0).getMessage()
        );
    }
}