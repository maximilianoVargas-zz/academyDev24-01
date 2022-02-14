@isTest
public with sharing class AccountTriggerTest {

    @TestSetup
    static void makeData(){
        List<Account> madeUpAccounts = new  List<Account>();
        Account madeUpAccount1 = new Account(
            Name = 'Futurama Clocks Factory',
            Identification_Type__c = 'NIT',
            Document_Number__c = '11222333'
        );
        madeUpAccounts.add(madeUpAccount1);

        Account madeUpAccount2 = new Account(
            Name = 'Back To The Future Clocks Factory',
            Identification_Type__c = 'NIT',
            Document_Number__c = '22333444'
        );
        madeUpAccounts.add(madeUpAccount2);

        insert madeUpAccounts;
    }

    @isTest
    static void whenInsertingAccountsCheckAccountValidationTrigger(){
        
        String errorMessage = 'ERROR: An account with this Document Number and Type Already Exits';
        List<Account> repeatedAccounts = new List<Account>();
        Account madeUpAccount3 = new Account(
            Name = 'Repeted Account 1',
            Identification_Type__c = 'NIT',
            Document_Number__c = '11222333'
        );

        repeatedAccounts.add(madeUpAccount3);

        Test.startTest();
        insert repeatedAccounts;
        Test.stopTest();

        Account aRepeatedAccount = [
            SELECT Conflict_Error__c
            FROM Account
            WHERE Conflict_Error__c = :errorMessage
            AND Document_Number__c = '11222333'
            LIMIT 1
        ];

        System.assertEquals(errorMessage, aRepeatedAccount.Conflict_Error__c, 
                            'No account found with the validation error');

    }


    @isTest
    static void whenUpdatingAccountsCheckAccountValidationTrigger(){
        
        String errorMessage = 'ERROR: An account with this Document Number and Type Already Exits';
        List<Account> updatedAccounts = new List<Account>();
        Account anExistingAccount = [
            SELECT Document_Number__c
            FROM Account
            WHERE Document_Number__c = '11222333'
            LIMIT 1
        ];

        anExistingAccount.Document_Number__c = '22333444';

        updatedAccounts.add(anExistingAccount);

        Test.startTest();
        update updatedAccounts;
        Test.stopTest();

        Account aRepeatedAccount = [
            SELECT Conflict_Error__c
            FROM Account
            WHERE Conflict_Error__c = :errorMessage
            AND Document_Number__c = '22333444'
            LIMIT 1
        ];

        System.assertEquals(errorMessage, aRepeatedAccount.Conflict_Error__c, 
                            'No account found with the validation error');

    }
}