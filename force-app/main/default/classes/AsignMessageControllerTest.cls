@isTest
public with sharing class AsignMessageControllerTest {

    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 6; i++) {
            accounts.add(new Account(Name = 'account' + i)); 
        }

        insert accounts;
    }
    
    @isTest static void controllerConstructorSuccess(){

        Test.startTest();
        AsignMessageController controller = new AsignMessageController();
        Test.stopTest();

        System.assert(!controller.wrappers.isEmpty(), 'The wrappers list must not be empty');
        System.assertEquals(6, controller.wrappers.size(), 'The number of wrappers does not match');
        System.assertNotEquals(null, controller.message, 'The message must not be null');
        System.assert(String.isBlank(controller.message.Description__c), 'The descripcion must be blank');
        System.assert(controller.accountsMessages.isEmpty(), 'The accountsMessages list must be empty');
    }

    @isTest static void asignMessagesFailBecauseThereAreNotAccountsWithTrue(){
        AsignMessageController controller = new AsignMessageController();
        controller.message.Description__c = 'una descripcion';
        String errorMessage;
        Boolean thereAreExceptions = false;

        Test.startTest();
        try {
            controller.asignMessages();            
        } catch (AsignMessageController.NotAccountToModifyException e) {
            thereAreExceptions = true;
            errorMessage = e.getMessage();
        }
        Test.stopTest();

        List<AccountMessage__c> accountsMessages = [
            SELECT Id, Account__c, Message__c
            FROM AccountMessage__c
        ];
        List<Message__c> messages = [
            SELECT Id
            FROM Message__c
        ];

        System.assert(accountsMessages.isEmpty(), 'The list of account-messages must be empty');
        System.assert(messages.isEmpty(), 'The list of messages must be empty');
        System.assert(thereAreExceptions, 'Exception not thrown');
        System.assertEquals(
            'Error: There are not accounts selected to set the message',
            errorMessage,
            'Error message does not match'
        );
    }

    @isTest static void asignMessagesFailBecauseTheMessageDescriptionIsBlank(){
        AsignMessageController controller = new AsignMessageController();
        String errorMessage;
        Boolean thereAreExceptions = false;
        for (Integer i = 0; i < 3; i++) {
            controller.wrappers[i].edit = true;
        }

        Test.startTest();
        try {
            controller.asignMessages();            
        } catch (AsignMessageController.DescriptionBlankException e) {
            thereAreExceptions = true;
            errorMessage = e.getMessage();
        }
        Test.stopTest();

        List<AccountMessage__c> accountsMessages = [
            SELECT Id, Account__c, Message__c
            FROM AccountMessage__c
        ];
        List<Message__c> messages = [
            SELECT Id
            FROM Message__c
        ];

        System.assert(accountsMessages.isEmpty(), 'The list of account-messages must be empty');
        System.assert(messages.isEmpty(), 'The list of messages must be empty');
        System.assert(thereAreExceptions, 'Exception not thrown');
        System.assertEquals(
            'Error: Message description must not be empty',
            errorMessage,
            'Error message does not match'
        );
    }

    @isTest static void asignMessagesSucces(){
        AsignMessageController controller = new AsignMessageController();

        controller.message.Description__c = 'una descripcion';
        Boolean thereAreExceptions = false;

        for (Integer i = 0; i < 3; i++) {
            controller.wrappers[i].edit = true;
        }

        Test.startTest();
        try {
            controller.asignMessages();            
        } catch (AsignMessageController.NotAccountToModifyException e) {
            thereAreExceptions = true;
        }
        Test.stopTest();

        List<AccountMessage__c> accountsMessages = [
            SELECT Id, Account__c, Message__c
            FROM AccountMessage__c
        ];
        List<Message__c> messages = [
            SELECT Id, Description__c
            FROM Message__c
        ];

        System.assert(!thereAreExceptions, 'Exception thrown');
        System.assert(!messages.isEmpty(), 'The list of messages must not be empty');
        System.assertEquals(1, messages.size(), 'the number of messages created does not match');
        System.assertEquals('una descripcion', messages.get(0).Description__c, 'The message description does not match');
        System.assert(!accountsMessages.isEmpty(), 'The list of account-messages must not be empty');
        System.assertEquals(3, accountsMessages.size(), 'the number of accounts-messages created does not match');
    }
    
}
