@isTest
public with sharing class AccountManageTest {
    @TestSetup
    static void makeData(){

        Account anAccount = new Account();
        anAccount.Name = 'Account To Update';
        anAccount.NumberOfEmployees = 350;
        anAccount.Identification_type__c = 'NIT';
        anAccount.Document_number__c = '39948687';

        insert anAccount;

        List<Account> accounts= new List<Account>();

        for(Integer i = 0; i < 10; i++){
            accounts.add(new Account(Name = 'Test AccountTrue' + i,
                                        Create_Opportunity__c = true));
        }
        for(Integer i = 0; i < 10; i++){
            accounts.add(new Account(Name = 'Test AccountFalse' + i,
                                        Create_Opportunity__c = false));
        }
        insert accounts;
    }

    @isTest
    static void createAccountWithTheValuesPassedIn() {

        string name = 'Test Account';
        integer numberOfEmployees = 500;
        string documentType = 'NIT';
        string documentNumber = '000001';

        Test.startTest();
        AccountManage.createAcccount(name, numberOfEmployees, documentType, documentNumber);
        Test.stopTest();

        List<Account> accounts = [
            SELECT Id
            FROM Account
            WHERE Name = 'Test Account'
                AND NumberOfEmployees = 500
                AND Identification_type__c = 'NIT'
                AND Document_number__c = '000001'
        ];

        System.assertEquals(1, accounts.size(), 'An account wasnt created correctly.');
    }

    @isTest
    static void updateAccountWithTheValuesPassedIn() {

        string name = 'Updated Account';
        integer numberOfEmployees = 500;
        string documentType = 'NIT';
        string documentNumber = '39948687';

        Test.startTest();
        AccountManage.updateAccount(name, numberOfEmployees, documentType, documentNumber);
        Test.stopTest();

        List<Account> accounts = [
            SELECT Id
            FROM Account
            WHERE Name = 'Updated Account'
                AND NumberOfEmployees = 500
                AND Identification_type__c = 'NIT'
                AND Document_number__c = '39948687'
        ];

        System.assertEquals(1, accounts.size(), 'An account wasnt updated correctly.');
    }

    @isTest
    static void consultAccountWithTheValuesPassedIn() {

        string documentType = 'NIT';
        string documentNumber = '39948687';

        Test.startTest();
        AccountManage.consultAccount(documentType, documentNumber);
        Test.stopTest();

        List<Account> accounts = [
            SELECT  Id
            FROM    Account
            WHERE   Identification_type__c = 'NIT'
                AND Document_number__c = '39948687'
        ];

        System.assertEquals(1, accounts.size(), 'No Accounts were found.');
    }

    @isTest
    static void consultAccountWithTheValuesPassedInButDontFindAnything() {

        string documentType = 'PP';
        string documentNumber = '39948687';

        Test.startTest();
        AccountManage.consultAccount(documentType, documentNumber);
        Test.stopTest();

        List<Account> accounts = [
            SELECT  Id
            FROM    Account
            WHERE   Identification_type__c = 'PP'
                AND Document_number__c = '39948687'
        ];

        System.assertEquals(0, accounts.size(), 'Accounts were found.');
    }

    @isTest
    static void deleteAccountWithTheValuesPassedIn() {

        string documentType = 'NIT';
        string documentNumber = '39948687';

        Test.startTest();
        AccountManage.deleteAccount(documentType, documentNumber);
        Test.stopTest();

        List<Account> accounts = [
            SELECT  Id
            FROM    Account
            WHERE   Identification_type__c = 'NIT'
                AND Document_number__c = '39948687'
        ];

        System.assertEquals(0, accounts.size(), 'Accounts were found.');
    }

    @isTest
    static void createOpportunityWhenAnAccountIsInsertedAndCreateOpportunityFieldEqualsToTrue(){
        
        List<String> accountIds = new List<String>();
        List<Account> insertedAccounts = [
                                         SELECT Id, Name, Create_Opportunity__c
                                         FROM   Account
                                         WHERE  Name LIKE 'Test AccountTrue%'
                                            OR  Name LIKE 'Test AccountFalse%'
                                         ];

        for(Account anAccount : insertedAccounts){
            accountIds.add(anAccount.Id);
        }

        List<Opportunity> opportunitiesToCheck = [
                                                 SELECT Id
                                                 FROM   Opportunity
                                                 WHERE  AccountId IN :accountIds
                                                 ];
        System.assertEquals(10, opportunitiesToCheck.size());
    }
}
