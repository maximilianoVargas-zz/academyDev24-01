@IsTest
public with sharing class AccountManageTest {
    
    @TestSetup
    static void makeData(){

        Account anAccount = new Account(Name = 'Cuenta 1', 
        NumberOfEmployees = 100, 
        Identification_type__c = 'NIT', 
        Document_number__c = '1234');

        insert anAccount;

    }

    @IsTest static void shouldCreateAccountWithSentDataAndReturnId() {
       
        Test.startTest();
        Id accountId = AccountManage.createAccount('Cuenta prueba', 5, 'CC', '123456');
        Test.stopTest();

        Account anAccount = [
            SELECT Id, Name, Identification_type__c, 
                Document_number__c, NumberOfEmployees
            FROM Account
            WHERE Account.Id = :accountId
        ];

        System.assertNotEquals(null, anAccount, 'The account was not created');        
        System.assertEquals('CC', anAccount.Identification_type__c, 'Account identification should be CC');
        System.assertEquals('123456', anAccount.Document_number__c, 'Account document should be 123456');
        System.assertEquals('Cuenta prueba', anAccount.Name, 'Account name should be Cuenta prueba');        
        System.assertEquals(5, anAccount.NumberOfEmployees, 'Account employees should be 5');
    }

    @IsTest static void whenExistsAccountWithTypeAndDocumentNumberShouldUpdateNameAndEmployees() {
       
        Test.startTest();
        Boolean result = AccountManage.updateAccount('Cuenta modificada', 50, 'NIT', '1234');
        Test.stopTest();

        System.assert(result, 'The account was not updated');

        Account anAccount = [
            SELECT Id, Name, Identification_type__c, 
                Document_number__c, NumberOfEmployees
            FROM Account
            WHERE Account.Document_number__c = '1234'
        ];
   
        System.assertEquals('Cuenta modificada', anAccount.Name, 'Account name should be Cuenta modificada');        
        System.assertEquals(50, anAccount.NumberOfEmployees, 'Account employees should be 50');
        
    }
    
    @IsTest static void whenNotExistsAccountWithTypeAndDocumentNumberShouldNotUpdate() {
       
        Test.startTest();
        Boolean result = AccountManage.updateAccount('Cuenta modificada', 50, 'NIT', '000');
        Test.stopTest();

        System.assert(!result, 'The account should not be updated');
        
    }

    @IsTest static void whenExistsAccountWithTypeAndDocumentNumberShouldDeteleIt() {
       
        Test.startTest();
        Boolean result = AccountManage.deleteAccount('NIT', '1234');
        Test.stopTest();

        System.assert(result, 'The result should be true');

        List<Account> accounts = [
            SELECT Id 
            FROM Account
            WHERE Document_number__c = '1234'
        ];

        System.assertEquals(0, accounts.size(), 'The account should be deleted');
        
    }

    @IsTest static void whenNotExistsAccountWithTypeAndDocumentNumberShouldReturnFalse() {
       
        Test.startTest();
        Boolean result = AccountManage.deleteAccount('NIT', '12340');
        Test.stopTest();

        System.assert(!result, 'The result should be false');
        
    }
    
    @IsTest static void whenExistsAccountWithTypeAndDocumentNumberShouldReturnData() {
       
        Test.startTest();
        Account anAccount = AccountManage.consultAccount('NIT', '1234');
        Test.stopTest();
       
        System.assertNotEquals(null, anAccount, 'Should return the account data');    
        
    }

    @IsTest static void whenNotExistsAccountWithTypeAndDocumentNumberShouldReturnNull() {
       
        Test.startTest();
        Account anAccount = AccountManage.consultAccount('NIT', '12340');
        Test.stopTest();
       
        System.assertEquals(null, anAccount, 'Should not return data');    
        
    }
    
    @IsTest static void whenCreateOportunityIsTrueShouldCreateAnOpportunityAndRelatedToAccounts() {

        List<Account> accounts = new List<Account>();
        Account anAccount = new Account();
        anAccount.Name = 'Cuenta prueba';
        anAccount.Create_opportunity__c = true;
        accounts.add(anAccount);
        insert accounts;

        Test.startTest();        
        AccountManage.createOpportunity(accounts);
        Test.stopTest();

        List<Opportunity> opportunities = [
            Select Name, StageName, CloseDate
            From Opportunity 
            Where AccountId IN :accounts
        ];
               
        String name = 'Opportunity' + anAccount.Name + Date.today();
        Date closeDate = Date.today() + 30;  

        System.assertEquals(1, opportunities.size(), 'Should be one opportunity');
        System.assertEquals('Prospection', opportunities.get(0).StageName, 'Invalid stage name in opportunity');
        System.assertEquals(name, opportunities.get(0).Name, 'Invalid name in opportunity');
        System.assertEquals(closeDate, opportunities.get(0).CloseDate, 'Invalid CloseDate in opportunity');
    }
    
    @IsTest static void whenCreateOportunityIsFlaseOrNullShouldNotCreateAnOpportunity() {

        List<Account> accounts = new List<Account>();
        Account anAccount = new Account();
        anAccount.Name = 'Cuenta 1';
        anAccount.Create_opportunity__c = false;
        accounts.add(anAccount);
        
        Account otherAccount = new Account();
        otherAccount.Name = 'Cuenta 2';
        accounts.add(otherAccount);
        insert accounts;

        Test.startTest();        
        AccountManage.createOpportunity(accounts);
        Test.stopTest();

        List<Opportunity> opportunities = [
            Select Name, StageName, CloseDate
            From Opportunity 
            Where AccountId IN :accounts
        ];
               
        System.assertEquals(0, opportunities.size(), 'Should not created an opportunity');
    }

}