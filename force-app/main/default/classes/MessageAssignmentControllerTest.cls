@isTest
public with sharing class MessageAssignmentControllerTest {
    
    @TestSetup
    static void makeData(){
        // Create 10 accounts
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            accounts.add(new Account(
                Name = 'Prueba ' + i
            ));
        }
        insert accounts;
    }

    @IsTest
    static void whenControllerIsInstantiated_ExactlyTenAccountsAreRetrieved(){
        Test.startTest();
        MessageAssignmentController controller = new MessageAssignmentController();
        Test.stopTest();
        
        system.assertEquals(10, controller.wrapAccountList.size(), 'Exactly 10 accounts mest be retrieved');
    }

    @IsTest
    static void whenTryToCreateMessageWithZeroAccountsSelected_ThenNoCreationIsMade_AndErrorMessageIsShown(){
        MessageAssignmentController controller = new MessageAssignmentController();
        // Update description
        controller.description = 'description';
        
        Test.startTest();
        controller.createMessage();
        Test.stopTest();
        
        system.assertEquals(true, controller.showErrorMessage, 'The error message must be visible');
        // Assert that no messages have been created
        List<Message__c> messages = [
            SELECT Id
            FROM Message__c
        ];
        system.assertEquals(0, messages.size(), 'Zero messages must have been created');
    }

    @IsTest
    static void whenTryToCreateMessageWithNoDescription_ThenNoCreationIsMade_AndErrorMessageIsShown(){
        MessageAssignmentController controller = new MessageAssignmentController();
        // Select 2 accounts
        for (Integer i = 0; i < 2; i++) {
            controller.wrapAccountList.get(i).selected = true;
        }

        Test.startTest();
        controller.createMessage();
        Test.stopTest();
        
        system.assertEquals(true, controller.showErrorMessage, 'The error message must be visible');
        // Assert that no messages have been created
        List<Message__c> messages = [
            SELECT Id
            FROM Message__c
        ];
        system.assertEquals(0, messages.size(), 'Zero messages must have been created');
    }

    @IsTest
    static void whenTryToCreateMessageWithSomeAccountsSelected_ThenCreationIsSuccessful_AndSuccessMessageIsShown_AndErrorMessageIsNotShown(){
        MessageAssignmentController controller = new MessageAssignmentController();
        // Select 2 accounts
        for (Integer i = 0; i < 2; i++) {
            controller.wrapAccountList.get(i).selected = true;
        }
        // Update description
        controller.description = 'description';

        Test.startTest();
        controller.createMessage();
        Test.stopTest();
        
        system.assertEquals(false, controller.showErrorMessage, 'The error message must not be visible');
        system.assertEquals(true, controller.showSuccessMessage, 'The success message must be visible');

        // Assert that 1 message was created with the correct description
        List<Message__c> messages = [
            SELECT Id, description__c
            FROM Message__c
        ];
        system.assertEquals(1, messages.size(), 'Exactly 1 message must have been created');
        system.assertEquals(
            'description', 
            messages.get(0).description__c, 
            'The message created must have the correct description'
        );

        // Assert that the 2 accounts and the 1 message are now related

        Account firstAccount = [
            SELECT Id
            FROM Account
            LIMIT 1
        ];
        Message_Account_Association__c firstAssociation = [
            SELECT Account__c, Message__c
            FROM Message_Account_Association__c
            WHERE Account__c = :firstAccount.Id
        ];
        system.assertEquals(
            messages.get(0).Id, 
            firstAssociation.Message__c, 
            'The created message and the first account must be related'
        );

        Account secondAccount = [
            SELECT Id
            FROM Account
            LIMIT 1
        ];
        Message_Account_Association__c secondAssociation = [
            SELECT Account__c, Message__c
            FROM Message_Account_Association__c
            WHERE Account__c = :secondAccount.Id
        ];
        system.assertEquals(
            messages.get(0).Id, 
            secondAssociation.Message__c, 
            'The created message and the second account must be related'
        );
    }
}
