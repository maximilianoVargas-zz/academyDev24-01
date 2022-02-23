@isTest
public with sharing class AccountManageTest {
    @isTest static void testWhenCreateAnOpportunity() {
        Account carlos = new Account(
            Name = 'carlos', 
            Identification_type__c = 'NIT', 
            Document_number__c = '3214567890', 
            Create_opportunity__c = true
        );
        Account carlitos = new Account(
            Name = 'carlitos', 
            Identification_type__c = 'NIT', 
            Document_number__c = '3214567891', 
            Create_opportunity__c = false
        );
        Account carla = new Account(
            Name = 'carla', 
            Identification_type__c = 'NIT', 
            Document_number__c = '3214567892', 
            Create_opportunity__c = true
        );
        List<Account> accounts = new List<Account>();
        accounts.add(carlos);
        accounts.add(carlitos);
        accounts.add(carla);
        insert accounts;
        Test.startTest();
        AccountManage.createOpportunity(accounts);
        Test.stopTest();
        List<Opportunity> oppCarlos = [
            SELECT Name, StageName, closeDate, AccountId
            FROM Opportunity
            WHERE AccountId = :carlos.Id
        ];
        List<Opportunity> oppCarlitos = [
            SELECT Name, StageName, closeDate, AccountId
            FROM Opportunity
            WHERE AccountId = :carlitos.Id
        ];
        List<Opportunity> oppCarla = [
            SELECT Name, StageName, closeDate, AccountId
            FROM Opportunity
            WHERE AccountId = :carla.Id
        ];  
        System.assert(!oppCarlos.isEmpty(), 'Carlos must have an assosiated opportunity');
        System.assert(oppCarlitos.isEmpty(), 'Carlitos must not have any assosiated opportunities');
        System.assert(!oppCarla.isEmpty(), 'Carla must have an assosiated opportunity');
    }

    @isTest static void createAccountWithNullParameterMustThrowAnException(){
        String name = 'account1';
        Integer number_employees = 3;
        String document_type = null;
        String document_number = '1234567890'; 

        Boolean thereIsException = false;
        String textException = '';

        Test.startTest();
        try {
            String id = AccountManage.createAccount(name, number_employees, document_type, document_number);
        } catch (IllegalArgumentException e) {
            thereIsException = true;
            textException = e.getMessage();
        }
        Test.stopTest();

        System.assert(thereIsException, 'It must throw an illegal argument exception');
        System.assertEquals('The parameters must not be null', 
            textException, 'The exception messagge is not correct'
        );
    }

    @isTest static void createAccountSuccessful(){
        String name = 'account1';
        Integer number_employees = 3;
        String document_type = 'NIT';
        String document_number = '1234567890'; 

        Test.startTest();
        String id = AccountManage.createAccount(name, number_employees, document_type, document_number);
        Test.stopTest();

        Account result = [
            SELECT Name, NumberOfEmployees, Identification_type__c, Document_number__c
            FROM Account
            LIMIT 1
        ];

        System.assertEquals('account1', result.Name, 'The account name does not match');
        System.assertEquals(3, result.NumberOfEmployees, 
            'The number of employees of the account does not match'
        );
        System.assertEquals('NIT', result.Identification_type__c, 
            'The account identification type does not match'
        );
        System.assertEquals('1234567890', result.Document_number__c, 'The document number does not match');
    }


    @isTest static void updateAccountWhenDoesNotExists(){
        Account anAccount = new Account(
            Name = 'account1',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );

        insert anAccount;

        String name = 'account2';
        Integer number_employees = 5;
        String document_type = 'NIT';
        String document_number = '1234567891'; 

        Test.startTest();
        Boolean result = AccountManage.UpdateAccount(name, number_employees, document_type, document_number);
        Test.stopTest();

        System.assertEquals(false, result, 'The expected boolean result does not match');
    }

    @isTest static void updateAccountSuccessful(){
        Account anAccount = new Account(
            Name = 'account1',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );

        insert anAccount;

        String name = 'account1';
        Integer number_employees = 5;
        String document_type = 'NIT';
        String document_number = '1234567890'; 

        Test.startTest();
        Boolean result = AccountManage.updateAccount(name, number_employees, document_type, document_number);
        Test.stopTest();

        Account accountResult = [
            SELECT Name, NumberOfEmployees, Identification_type__c, Document_number__c
            FROM Account
            LIMIT 1
        ];

        System.assert(result, 'The expected boolean result does not match');
        System.assertEquals('account1', accountResult.Name, 'The account name does not match');
        System.assertEquals(5, accountResult.NumberOfEmployees, 'The number of employees does not match');
        System.assertEquals('NIT', accountResult.Identification_type__c, 'The identification type does not match');
        System.assertEquals('1234567890', accountResult.Document_number__c, 'The document number does not match');
    }

    @isTest static void deleteAccountWhenDoesNotExistTheAccount(){
        Account anAccount = new Account(
            Name = 'account1',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );

        insert anAccount;

        String document_type = 'NIT';
        String document_number = '1234567891'; 

        Test.startTest();
        Boolean result = AccountManage.deleteAccount(document_type, document_number);
        Test.stopTest();

        System.assert(!result, 'The boolean result does not match, it must be false');
    }

    @isTest static void deleteAccountSuccessful(){
        Account anAccount = new Account(
            Name = 'account1',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );

        insert anAccount;

        String document_type = 'NIT';
        String document_number = '1234567890'; 

        Test.startTest();
        Boolean result = AccountManage.deleteAccount(document_type, document_number);
        Test.stopTest();

        System.assert(result, 'The boolean result does not match, it must be true');
    }

    @isTest static void consultAccountWhenExistsTheAccount(){
        Account anAccount1 = new Account(
            Name = 'account1',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );

        Account anAccount2 = new Account(
            Name = 'account2',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567891' 
        );

        List<Account> accounts = new List<Account>();
        accounts.add(anAccount1);
        accounts.add(anAccount2);
        
        insert accounts;
        
        String name = 'account2';
        Integer number_employees = 3;
        String document_type = 'NIT';
        String document_number = '1234567891';

        Test.startTest();
        Account result = AccountManage.consultAccount(document_type, document_number);
        Test.stopTest();

        System.assertEquals(name, result.Name, 'The account name does not match');
        System.assertEquals(number_employees, result.NumberOfEmployees, 'The number of employees does not match');
        System.assertEquals(document_type, result.Identification_type__c, 'The identification type does not match');
        System.assertEquals(document_number, result.Document_number__c, 'The document number does not match');
    }

    @isTest static void consultAccountWhenNotExistsTheAccount(){
        Account anAccount1 = new Account(
            Name = 'account1',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );

        Account anAccount2 = new Account(
            Name = 'account2',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567891' 
        );

        List<Account> accounts = new List<Account>();
        accounts.add(anAccount1);
        accounts.add(anAccount2);
        
        insert accounts;
        
        String name = 'account3';
        Integer number_employees = 3;
        String document_type = 'NIT';
        String document_number = '1234567892';

        Test.startTest();
        Account result = AccountManage.consultAccount(document_type, document_number);
        Test.stopTest();

        System.assertEquals(null, result, 'The account is not null');
    }
}