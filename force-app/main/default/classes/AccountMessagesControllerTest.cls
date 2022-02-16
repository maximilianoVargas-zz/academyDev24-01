@IsTest
public with sharing class AccountMessagesControllerTest {
    
    @TestSetup
    static void makeData(){

        List<Account> accounts = new List<Account>();
        for (Integer i = 1;  i <= 10; i++) {
            Account anAccount = new Account(
                Name = 'Cuenta ' +i,
                Identification_type__c = 'NIT', 
                Document_number__c = '1234' + i
            );
            accounts.add(anAccount);
        }
        insert accounts;

    }

    @IsTest static void shouldGetAllAccounts() {

        AccountMessagesController anController = new AccountMessagesController();

        Test.startTest();
        List<AccountMessagesController.AccountSelected> accounts = anController.getAccounts();
        Test.stopTest();

        System.assertEquals(10, accounts.size(), 'Should be 10 accounts');
    }

    @IsTest static void shouldSaveTheMessageAndRelatedWitheAccountList() {
        
        AccountMessagesController anController = new AccountMessagesController();
        anController.description = 'Mensaje prueba';
        
        List<AccountMessagesController.AccountSelected> accounts = anController.getAccounts();
        for (AccountMessagesController.AccountSelected anAccountSelected : accounts) {
            anAccountSelected.selected = true;
        }

        Test.startTest();
        anController.saveMessage();
        Test.stopTest();

        List<Account> accountsResult = [
            SELECT Id, 
                (SELECT Message__r.Description__c 
                FROM AccountMessageAssociations__r)
            FROM Account
        ];

        System.assertEquals(10, accountsResult.size(), 'Should be 10 accounts');

        for (Account anAccount : accountsResult) {
            System.assertEquals(1, anAccount.AccountMessageAssociations__r.size(), 'Should be one message related');            
            System.assertEquals('Mensaje prueba', anAccount.AccountMessageAssociations__r.get(0).Message__r.Description__c, 
                                    'The message should be Mensaje prueba');
        }

    }

}
