@isTest
public with sharing class AccountManageTest {
    @TestSetup
    static void testData(){
        Account anAccount = new Account(
            Name = 'TestAccount',
            NumberOfEmployees = 100,
            Identification_Type__c = 'NIT',
            Document_Number__c = '12345678'
        );
        insert anAccount;
    }
    @isTest
    static void ConfirmCreatedAccount(){
        
        Test.startTest();
        AccountManage.createAccount('TestAccount2', 100, 'NIT', '87654321');
        Test.stopTest();

        Account anAccount = [
            SELECT Name
            FROM Account
            WHERE Name = 'TestAccount2'
            LIMIT 1
        ];
        System.assertEquals('TestAccount2', anAccount.Name, 
        'Name Mismatch - Account doesn`t exist.');
    }
    @isTest
    static void ConfirmUpdatedAccount(){

        Test.startTest();
        AccountManage.updateAccount('TestAccount', 150, 'NIT', '87654321');
        Test.stopTest();

        Account anAccount = [
            SELECT NumberOfEMployees
            FROM Account
            WHERE Name = 'TestAccount'
        ];
        System.assertEquals(150, anAccount.NumberOfEmployees, 
        'Number of employees field wasn`t updated.');
    }
    @isTest
    static void ConfirmDeletedAccount(){

        Test.startTest();
        Boolean result = AccountManage.deleteAccount('NIT', '12345678');
        Test.stopTest();

        System.assertEquals(true, result, 
        'Account wasn`t deleted for some reason.');
    }
    @isTest
    static void ConfirmConsultAccount(){

        Test.startTest();
        Account anAccount = AccountManage.consultAccount('NIT', '12345678');
        Test.stopTest();

        System.assertEquals('12345678', anAccount.Document_Number__c, 
        'Specified Identification type or Document Number don`t match with any existing account.');
    }
    @isTest
    static void ConfirmConsultAccountNullResponseWhenRequestingParametersThatDoesntExist(){

        Test.startTest();
        Boolean anAccount = (AccountManage.consultAccount('NIT', '11111111')) == null;
        Test.stopTest();

        System.assertEquals(true, anAccount, 
        'Result is not null, invalid parameters passed.');
    }
    @isTest 
    static void ConfirmOpportunitiesCreatedWhenCreateOpportunityFieldIsTrueInNewAccounts(){
        List<Account> accountList = new List<Account>();
        accountList.add(new Account(
            Name = 'CreateOppAccount',
            Create_Opportunity__c = true
        ));
        accountList.add(new Account(
            Name = 'DontCreateOppAccount',
            Create_Opportunity__c = false
        ));
        insert accountList;

        Test.startTest();
        AccountManage.createOpportunity(accountList);
        Test.stopTest();

        List<Opportunity> oppList = [
            SELECT Id, AccountId
            FROM Opportunity
            WHERE AccountId = :accountList
        ];
        System.assertEquals(1, oppList.size(),
         'Something went wrong when inserting opportunities for Create_Opportunity__c Checked accounts');
    }
}
