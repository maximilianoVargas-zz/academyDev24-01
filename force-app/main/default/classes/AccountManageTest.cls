@isTest
public with sharing class AccountManageTest {

    @TestSetup
    static void makeData(){
        Account anAccount = new Account(Name = 'Test General', Identification_type__c = 'CC', Document_number__c = 'A1234', NumberOfEmployees = 1);
        insert anAccount;
    }

    @isTest
    public static void whenAccountNeedToCreateAnOpportunity() {
        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < 10; i++) {
            accounts.add(
                new Account(
                    Name = 'test' + i,
                    Create_Opportunity__c = true
                )
            );
        }

        Test.startTest();
        insert accounts;
        AccountManage.createOpportunity(accounts);
        Test.stopTest();
        Map<Id, Account> accountsById = new Map<Id, Account>();
        for(Account anAccount : accounts) {
            accountsById.put(anAccount.Id, anAccount);
        }

        List<Opportunity> opportunities = [SELECT Id, AccountId FROM Opportunity];

        System.assertEquals(10, opportunities.size(), 'Las oportunidades no tienen el mismo tamaño que las accounts');

        for(Opportunity op : opportunities) {
            Account ac = accountsById.get(op.AccountId);
            System.assertEquals(op.AccountId, ac.Id, 'La oportunidad no esta relacionada con la cuenta');
        }

    }

    @isTest
    static void whenCreateAccount() {
        Test.startTest();
        Id anId = AccountManage.createAccount('Test 1', 1, 'CC', '1234');
        Test.stopTest();
        System.assertNotEquals(null, anId, 'The account wasnt create');
    }

    @isTest
    static void whenUpdateAccount() {
        Account anAccount = [SELECT Id, Name, NumberOfEmployees, Document_number__c, Identification_type__c FROM Account];
        Test.startTest();
        AccountManage.updateAccount(anAccount.Name, 5, anAccount.Identification_type__c, anAccount.Document_number__c);
        Test.stopTest();
        Account anAccountUpdated = [SELECT Id, Name, NumberOfEmployees, Document_number__c, Identification_type__c FROM Account];
        System.assertNotEquals(anAccount.NumberOfEmployees, anAccountUpdated.NumberOfEmployees, 'The account wasnt update');
    }

    @isTest
    static void whenConsultAccount() {
        Account anAccount = [SELECT Id, Name, NumberOfEmployees, Document_number__c, Identification_type__c FROM Account];
        Account anAccountConsulted = AccountManage.consultAccount(anAccount.Identification_type__c, anAccount.Document_number__c);
        System.assertEquals(anAccount.Name, anAccountConsulted.Name, 'The account not found');
    }

    @isTest
    static void whenDeleteAccount() {
        Account anAccount = [SELECT Id, Name, NumberOfEmployees, Document_number__c, Identification_type__c FROM Account];
        Test.startTest();
        AccountManage.deleteAccount(anAccount.Identification_type__c, anAccount.Document_number__c);
        Test.stopTest();
        List<Account> anAccountDeleted = [SELECT Id, Name, NumberOfEmployees, Document_number__c, Identification_type__c FROM Account];
        System.assertEquals(true, anAccountDeleted.isEmpty(), 'The account wans delete');
    }
    
}