@IsTest
public with sharing class AccountTriggerTest {

    @TestSetup
    static void makeData(){

        Account anAccount = new Account(
            Name = 'Cuenta 1',
            Document_number__c = '123',
            Identification_type__c = 'CC'
        );

        Account otherAccount = new Account(
            Name = 'Cuenta 2',
            Document_number__c = '1234',
            Identification_type__c = 'CC'
        );

        insert anAccount;
        insert otherAccount;

    }

    @IsTest static void insertAccountWhenTypeAndDocumentNotExists() {
        
        Account anAccount = new Account(
            Name = 'Cuenta 3',
            Document_number__c = '12345',
            Identification_type__c = 'CC'
        );

        Test.startTest();
        Database.SaveResult result = Database.insert(anAccount);
        Test.stopTest();

        System.assert(result.success, 'Should create the account');
    }

    @IsTest static void insertAccountWhenTypeAndDocumentAlreadyExistsShouldGetError() {

        Account anAccount = new Account(
            Name = 'Cuenta 4',
            Document_number__c = '123',
            Identification_type__c = 'CC'
        );

        Test.startTest();
        Database.SaveResult result = Database.insert(anAccount, false);
        Test.stopTest();

        System.assert(!result.success, 'Should not create the account');
        System.assertEquals('An account already exists with the same document type and number', 
            result.getErrors().get(0).getMessage(), 'Should return error account already exists');
    }

    @IsTest static void updateAccountWhenTypeAndDocumentNotExists() {
        
        Account anAccount = [
            SELECT Id 
            FROM Account
            WHERE Name = 'Cuenta 1'
        ];

        anAccount.Name = 'Cuenta Actualizada';

        Test.startTest();
        Database.SaveResult result = Database.update(anAccount);
        Test.stopTest();

        System.assert(result.success, 'Should update the account');
    }

    @IsTest static void updateAccountWhenTypeAndDocumentAlreadyExistsShouldGetError() {
        
         Account anAccount = [
            SELECT Id 
            FROM Account
            WHERE Name = 'Cuenta 1'
        ];
        
        anAccount.Document_number__c = '1234';

        Test.startTest();
        Database.SaveResult result = Database.update(anAccount, false);
        Test.stopTest();

        System.assert(!result.success, 'Should not update the account');
        System.assertEquals('An account already exists with the same document type and number', 
            result.getErrors().get(0).getMessage(), 'Should return error account already exists');
    }

}
