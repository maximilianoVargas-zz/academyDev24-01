@isTest
public class AccountManageTest {
    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        Account aSpecialAccount = new Account(Name='Test Special Account', 
                                            NumberOfEmployees=10, 
                                            Identification_Type__c= 'NIT', 
                                            Document_Number__c='0123456789');
        accounts.add(aSpecialAccount);

        for (Integer i = 0; i < 5; i++) {
            Account testAccount = new Account(Name='Test Account ' + i);
            accounts.add(testAccount);
        }
        insert accounts;
    }

    @isTest static void shouldCreateANewAccount(){
        Test.startTest();
        AccountManage.createAccount('Test Created Account',5,'NIT','abc1234560');
        Test.stopTest();

        List<Account> accounts = [
            SELECT Id 
            FROM Account 
            WHERE Name LIKE 'Test%'
            ];
        System.assertEquals(7, accounts.size());
    }

    @isTest static void shouldUpdateAnExistingAccount(){
        Test.startTest();
        AccountManage.updateAccount('New Special Account',6,'NIT', '0123456789');
        Test.stopTest();

        List<Account> accounts = [
            SELECT Id 
            FROM Account 
            WHERE Name LIKE 'New Special%'
            ];
        System.assertEquals(1, accounts.size());
    }

    @isTest static void shouldDeletAnExistingAccount(){
        Test.startTest();
        AccountManage.deleteAccount('NIT', '0123456789');
        Test.stopTest();

        List<Account> accounts = [
            SELECT Id 
            FROM Account 
            WHERE Name LIKE 'Test%'
            ];
        System.assertEquals(5, accounts.size());
    }

    @isTest static void shouldCreateAnOpportunityCorrectly(){

        List<Account> accounts = [
            SELECT Id, Name 
            FROM Account 
            WHERE Name LIKE 'Test Account%'
            ];

        Test.startTest();
        AccountManage.createOpportunity(accounts);
        Test.stopTest();

        List<Opportunity> opp = [
            SELECT Id, Name 
            FROM Opportunity 
            WHERE Name LIKE 'Test Account%'
            ];
        System.assertEquals(5, opp.size(), 'Something went wrong');
    }
}
