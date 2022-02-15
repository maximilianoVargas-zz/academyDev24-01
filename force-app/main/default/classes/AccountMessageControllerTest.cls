@IsTest
public with sharing class AccountMessageControllerTest {

    @IsTest
    static void getAccountsTest() {
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='Mi cuenta 1'));
        accounts.add(new Account(Name='Mi cuenta 2'));
        accounts.add(new Account(Name='Mi cuenta 3'));
        accounts.add(new Account(Name='Mi cuenta 4'));
        accounts.add(new Account(Name='Mi cuenta 5'));
        insert accounts;

        AccountMessageController controller = new AccountMessageController();
        
        Test.startTest();
        List<AccountMessageController.WrapperAccount> wrapperAccounts = controller.getAccounts();
        Test.stopTest();

        System.assertEquals(5, wrapperAccounts.size(), 'La cantidad de cuentas no es correcta.');
    }

    @IsTest
    static void sendMessageTestEmptyDescripction() {
        AccountMessageController controller = new AccountMessageController();
        
        Test.startTest();
        controller.message.Description__c = '';
        controller.sendMessage();
        controller.message.Description__c = null;
        controller.sendMessage();
        Test.stopTest();

        List<Message__c> messages = [
            SELECT Id, Description__c
            FROM Message__c
        ];

        System.assertEquals(0, messages.size(), 'No se deberia haber insertado ningun mensaje.');
       
    }

    @IsTest
    static void sendMessageOk() {
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='Mi cuenta 1'));
        accounts.add(new Account(Name='Mi cuenta 2'));
        accounts.add(new Account(Name='Mi cuenta 3'));
        accounts.add(new Account(Name='Mi cuenta 4'));
        accounts.add(new Account(Name='Mi cuenta 5'));
        insert accounts;

        AccountMessageController controller = new AccountMessageController();
        controller.message.Description__c = 'Mi mensaje';
        List<AccountMessageController.WrapperAccount> wrapperAccounts = controller.getAccounts();
        for (AccountMessageController.WrapperAccount wrapper : wrapperAccounts) {
            wrapper.selected = true;
        }
        
        Test.startTest();
        controller.sendMessage();
        Test.stopTest();

        List<AccountMessage__c> accountMessages = [
            SELECT Id
            FROM AccountMessage__c
        ];
        List<Message__c> messages = [
            SELECT Id, Description__c
            FROM Message__c
        ];

        System.assertEquals(1, messages.size(), 'Deberia haber exactamente un mensaje.');
        System.assertEquals(5, accountMessages.size(), 'La cantidad de mensaje-cuentas no es correcta.');
    }

}