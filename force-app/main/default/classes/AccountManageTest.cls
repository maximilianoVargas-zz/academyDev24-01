@isTest
public with sharing class AccountManageTest {

    private static final Integer ACCOUNT_NUMBER = 300;
    
    @testSetup
    public static void makeData(){
        // Create some accounts
        List<Account> accounts = new List<Account>();
        for(integer i = 0; i < ACCOUNT_NUMBER; i++){
            accounts.add(
                new Account(
                    Name = 'Cuenta ' + i,
                    Create_Opportunity__c = True,
                    Identification_Type__c = 'NIT',
                    Document_Number__c = EncodingUtil.base64encode(Crypto.generateAesKey(192)).substring(0, 10)
                )
            );
        }
        insert accounts;
    }

    @isTest
    public static void whenGivenAccountsWithCreateOpportunityCheckboxActivated_OpportunitiesAreCreatedRelatedToThoseAccounts() {        
        List<Account> accounts = [
            SELECT Id, Create_Opportunity__c, Name
            FROM Account
        ];

        // Execute method under test
        Test.startTest();
        AccountManage.createOpportunity(accounts);
        Test.stopTest();

        // Assertions
        List<Opportunity> opportunities = [
            SELECT Name
            FROM Opportunity
            WHERE AccountId IN :accounts
        ];
        system.assertEquals(ACCOUNT_NUMBER, opportunities.size());
    }

    @isTest
    public static void testCreateAccount() {
        Test.startTest();
        String id = AccountManage.createAccount('name', 100, 'NIT', '12345678');
        Test.stopTest();

        //Assertions
        List<Account> accounts = [
            SELECT Id, Name, NumberOfEmployees, Identification_Type__c, Document_Number__c
            FROM Account
            WHERE Name = 'name' AND NumberOfEmployees = 100 AND Identification_Type__c = 'NIT' AND Document_Number__c = '12345678'
        ];
        System.assertEquals(1, accounts.size());
        System.assertEquals(id, accounts.get(0).Id);
    }

    @isTest
    public static void testUpdateAccount() {
        // Get any account
        Account account = [
            SELECT Id, Identification_Type__c, Document_Number__c
            FROM Account
            LIMIT 1
        ];
        Test.startTest();
        Boolean result = AccountManage.updateAccount(
            'updated', 
            101, 
            account.Identification_Type__c, 
            account.Document_Number__c
        );
        Test.stopTest();
        // Assertions
        List<Account> accounts = [
            SELECT Id
            FROM Account
            WHERE Name = 'updated' AND NumberOfEmployees = 101
        ];
        system.assertEquals(1, accounts.size());
        system.assert(result);
    }

    @isTest
    public static void testUpdateInvalidAccount() {
        Test.startTest();
        Boolean result = AccountManage.updateAccount('updated', 101, 'i dont exist', 'i dont exist');
        system.assertEquals(false, result);
    }

    @isTest
    public static void testConsultAccount() {
        // Get any account
        Account account = [
            SELECT ID, Name, NumberOfEmployees, Identification_Type__c, Document_Number__c
            FROM Account
            LIMIT 1
        ];
        Test.startTest();
        Account consultedAccount = AccountManage.consultAccount(
            account.Identification_Type__c, 
            account.Document_Number__c
        );
        Test.stopTest();
        // Assertions
        system.assertEquals(account.ID, consultedAccount.ID);
        system.assertEquals(account.Name, consultedAccount.Name);
        system.assertEquals(account.NumberOfEmployees, consultedAccount.NumberOfEmployees);
        system.assertEquals(account.Identification_Type__c, consultedAccount.Identification_Type__c);
        system.assertEquals(account.Document_Number__c, consultedAccount.Document_Number__c);
    }

    @isTest
    public static void testConsultInvalidAccount() {
        Test.startTest();
        Account result = AccountManage.consultAccount('i dont exist', 'i dont exist');
        system.assertEquals(null, result);
    }

    @isTest
    public static void testDeleteAccount() {
        // Get any account
        Account account = [
            SELECT ID, Identification_Type__c, Document_Number__c
            FROM Account
            LIMIT 1
        ];
        Test.startTest();
        Boolean result = AccountManage.deleteAccount(
            account.Identification_Type__c, 
            account.Document_Number__c
        );
        Test.stopTest();
        // Assertions
        system.assert(result);
        List<Account> accounts = [
            SELECT ID
            FROM Account
            WHERE Identification_Type__c = :account.Identification_Type__c 
                AND Document_Number__c = :account.Document_Number__c
        ];
        system.assertEquals(0, accounts.size());
    }

    @isTest
    public static void testDeleteInvalidAccount() {
        Test.startTest();
        Boolean result = AccountManage.deleteAccount('i dont exist', 'i dont exist');
        system.assertEquals(false, result);
    }
}