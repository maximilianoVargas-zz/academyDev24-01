@isTest
public with sharing class MessageAccountControllerTest {
    
    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < 10; i++) {
            Account anAccount = new Account(Name = 'Test ' + i);
            accounts.add(anAccount);
        }

        insert accounts;
    }

    @isTest
    static void whenControllerIsIntancied() {
        MessageAccountsController myController = new MessageAccountsController();
        System.assertEquals(10, myController.wrapAccountList.size(), 'The accounts no match');
    }

    @isTest
    static void whenMessageOrSelectedListAreEmpty() {
        MessageAccountsController myController = new MessageAccountsController();
        myController.save();
        List<Message__c> aMessage = [SELECT Id, Name FROM Message__c];
        System.assertEquals(0, aMessage.size(), 'Message Created');
        myController.message = 'Test Message';
        myController.save();
        List<Message__c> aMessageRevalidate = [SELECT Id, Name FROM Message__c];
        System.assertEquals(0, aMessageRevalidate.size(), 'Message Created');
    }

    @isTest
    static void whenMessageAndSelectedListArentEmpty() {
        MessageAccountsController myController = new MessageAccountsController();
        for(MessageAccountsController.WrapAccount aWrap : myController.wrapAccountList) {
            aWrap.selected = true;
        }
        myController.processAccountSelected();
        myController.message = 'Test Message';
        myController.save();
        List<Message__c> aMessage = [SELECT Id, Name FROM Message__c];
        System.assertEquals(1, aMessage.size(), 'No message created');
        MessageInAccount__c[] messages = [SELECT Id FROM MessageInAccount__c];
        System.assertEquals(10, messages.size(), 'No messages in accounts created');
    }

}
