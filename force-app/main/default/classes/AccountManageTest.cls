@isTest
public with sharing class AccountManageTest {
    @TestSetup
    static void makeData(){
        Account madeUpAccount = new Account(
            Name = 'Santas Lil Helpers Toy Making',
            NumberOfEMployees = 50,
            Identification_Type__c = 'NIT',
            Document_Number__c = '11222333'
        );
        insert madeUpAccount;
    }

    /*Maxi es válido este test? No sabía cómo finjir un Id para probar que retorna un id
    El test pasa o sea demuestra que la cuenta con ese Document Number existe*/
    @isTest
    static void whenCreatingAnAccountCheckIfAccountWasCreated(){
        String name = 'Acme RoadRunner Hunting Devices';
        Integer numberOfEmployees = 20;
        String identificationType = 'NIT';
        String documentNumber = '33333333';
        
        Test.startTest();
        AccountManage.createAccount(name, numberOfEmployees, identificationType, documentNumber);
        Test.stopTest();

        Account anAccount = [
            SELECT Document_Number__c
            FROM Account
            WHERE Document_Number__c = '33333333'
            LIMIT 1];

        System.assertEquals('33333333', anAccount.Document_Number__c, 
        'The Document Numbers do not match or there is no account created with that Document Number');
    }

    @isTest
    static void whenUpdatingAnAccountCheckIfAccountWasUpdated(){

        Account anAccount = [
            SELECT NumberOfEMployees
            FROM Account
            WHERE Document_Number__c = '11222333'
            AND NumberOfEMployees = 50
            LIMIT 1
        ];
        //Going to change the number of employees to test if account is updating from 50 to 100:
        Test.startTest();
        AccountManage.updateAccount('Santas Lil Helpers Toy Making', 100, 'NIT', '11222333');
        Test.stopTest();

        Account anUpdatedAccount = [
            SELECT NumberOfEMployees
            FROM Account
            WHERE Document_Number__c = '11222333'
            LIMIT 1
        ];

        System.assertEquals(100, anUpdatedAccount.NumberOfEMployees, 
        'The Number of Employees do not match or the account was not updates correctly');
    }

    @isTest
    static void whenAnAccountisDeletedCheckIfAccountWasSuccessfullyDeleted(){
        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Document_Number__c = '11222333'
            LIMIT 1
        ];

        Test.startTest();
        Boolean result = AccountManage.deleteAccount('NIT', '11222333');
        Test.stopTest();
        //Checks if the returning Database.delete --> .isSuccess() == true
        System.assert(result == true,
        'The account still exists, meaning it was not deleted successfully');
    }

    @isTest
    static void checkIfWhenConsultingAnAccountOneAccountIsReturned(){

        Test.startTest();
        Account anAccount = AccountManage.consultAccount('NIT', '11222333');
        Test.stopTest();

        System.assertEquals('11222333', anAccount.Document_Number__c, 
        'Document numbers do not match or an account with thad Document Number was not returned');
    }

    @isTest
    static void checkIfWhenConsultingAnAccountWithUnexistingParametersNullIsReturned(){

        Test.startTest();
        Boolean aNull = (AccountManage.consultAccount('NIT', '22333444')) == null;
        Test.stopTest();

        System.assert(aNull == true, 
        'Did not get a null meaning the method is not returning the correct value when an invalid parameter is passed');
    }
}
