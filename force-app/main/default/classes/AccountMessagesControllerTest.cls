@IsTest
public with sharing class AccountMessagesControllerTest {
    
    @TestSetup
    static void makeData(){
        Account account1 = new Account(
            Name = 'Cuenta 1',
            Identification_type__c = 'NIT', 
            Document_number__c = '1234'
        );

        Account account2 = new Account(
            Name = 'Cuenta 2',
            Identification_type__c = 'NIT', 
            Document_number__c = '12345'
        );

        insert account1;
        insert account2;
    }

    @IsTest static void shouldGetAllAccounts() {

        AccountMessagesController anController = new AccountMessagesController();

        Test.startTest();
        List<AccountSelected> accounts = anController.getAccounts();
        Test.stopTest();

        System.assertEquals(2, accounts.size(), 'Should be two accounts');
    }

    @IsTest static void shouldSaveTheMessageAndRelatedWitheAccountList() {
        
        AccountMessagesController anController = new AccountMessagesController();
        anController.description = 'Mensaje prueba';
        anController.accountsSelected = createAccountsSelected();

        Test.startTest();
        anController.saveMessage();
        Test.stopTest();

        List<Account> accountsResult = [
            SELECT Id, 
                (SELECT Message__r.Description__c 
                FROM AccountMessageAssociations__r)
            FROM Account
        ];

        System.assertEquals(2, accountsResult.size(), 'Should be two accounts');

        for (Account anAccount : accountsResult) {
            System.assertEquals(1, anAccount.AccountMessageAssociations__r.size(), 'Should be one message related');            
            System.assertEquals('Mensaje prueba', anAccount.AccountMessageAssociations__r.get(0).Message__r.Description__c, 
                                    'The message should be Mensaje prueba');
        }

    }

    private static List<AccountSelected> createAccountsSelected() {

        List<AccountSelected> accountsSelected = new List<AccountSelected>();

        for (Account anAccount : [SELECT Id FROM Account]) {
            AccountSelected accountSelected = new AccountSelected(true, anAccount);
            accountsSelected.add(accountSelected);
        }

        return accountsSelected;
    }
}
