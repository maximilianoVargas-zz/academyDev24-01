@isTest
public with sharing class AccountManageTest {
    @isTest
    static void createAnAccountWithNameNumberOfEmployeesIdentificationTypeAndDocumentNumber(){
        
        Account anAccount = new Account(
            Name = 'TestCreateAccount',
            NumberOfEmployees = 50,
            Identification_type__c = 'NIT',
            Document_Number__c = '24363027660'
        );

        anAccount.Id = AccountManage.createAcccount(anAccount.Name, anAccount.numberOfEmployees, anAccount.Identification_type__c, anAccount.Document_Number__c);

        Account anotherAccount = [
            SELECT Name, NumberOfEmployees, Identification_type__c, Document_Number__c
            FROM Account
            WHERE Name = :anAccount.Name
            LIMIT 1
        ];

        System.assertEquals(anAccount, anotherAccount, 'Accounts do not match');
    }

    @isTest
    static void updateAnAccountNameAndNumberOfEmployeesWithIdentificationTypeAndDocumentNumber(){
        Account anAccount = new Account(
            Name = 'TestUpdateAccount',
            NumberOfEmployees = 50,
            Identification_type__c = 'NIT',
            Document_Number__c = '24363027660'
        );

        Test.startTest();
        insert anAccount;
        Test.stopTest();

        Account anotherAccount = [
            SELECT Name, NumberOfEmployees, Identification_type__c, Document_Number__c
            FROM Account
            WHERE Name = :anAccount.Name
            LIMIT 1
        ];

        anotherAccount.Name = 'AccountUpdated';
        anotherAccount.NumberOfEmployees = 70;

        Boolean result = AccountManage.updateAccount(anotherAccount.Name, anotherAccount.NumberOfEmployees, anotherAccount.Identification_type__c, anotherAccount.Document_Number__c);

        Account accountUpdated = [
            SELECT Name, NumberOfEmployees, Identification_type__c, Document_Number__c
            FROM Account
            WHERE Identification_type__c = :anotherAccount.Identification_type__c
            AND Document_Number__c = :anotherAccount.Document_Number__c
            LIMIT 1
        ];

        System.assertEquals(true, result, 'Account not updated');
        System.assertEquals(anotherAccount, accountUpdated, 'Accounts do not match');
    }

    @isTest
    static void deleteAnAccountWithIdentificationTypeAndDocumentNumber(){
        Account anAccount = new Account(
            Name = 'TestUpdateAccount',
            NumberOfEmployees = 50,
            Identification_type__c = 'NIT',
            Document_Number__c = '24363027660'
        );

        Test.startTest();
        insert anAccount;
        Test.stopTest();

        Boolean result = AccountManage.deleteAccount(anAccount.Identification_type__c, anAccount.Document_Number__c);

        System.assertEquals(true, result, 'Account not deleted');
    }

    @isTest
    static void consultAnAccountWithIdentificationTypeAndDocumentNumber(){
        Account anAccount = new Account(
            Name = 'TestUpdateAccount',
            NumberOfEmployees = 50,
            Identification_type__c = 'NIT',
            Document_Number__c = '24363027660'
        );

        Test.startTest();
        insert anAccount;
        Test.stopTest();

        Account anotherAccount = AccountManage.consultAccount('NIT', '24363027660');
        Account nullAccount = AccountManage.consultAccount('CC', '123456789');

        System.assertEquals(anAccount, anotherAccount, 'Accounts do not match');
        System.assertEquals(null, nullAccount, 'Should return null');
    }
}