@isTest
private with sharing class AccountValidationTest {
    @isTest
    static void testvalidateError(){

        Account anAccount = new Account(
            Name = 'Test',
            Identification_type__c = 'NIT',
            Document_number__c = '12345678'
        );

        Test.startTest();
        Boolean result = AccountValidation.validateAccount(anAccount);
        Test.stopTest();

        System.assertEquals(true, result, 'Something went wrong when returning true or false.');
    }
    @isTest 
    static void testAddError(){

        Account anAccount = new Account(
            Name = 'Test',
            Identification_type__c = 'NIT',
            Document_number__c = '12345678'
        );
        insert anAccount;

        Test.startTest();
        Boolean result = AccountValidation.validateAccount(anAccount);
        Test.stopTest();

        System.assertEquals(false, result, 'Something went wrong when returning true or false.');
    }

}
