@isTest
public class MessageDescriptionForAccountsTest {
    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 15; i++){
            Account acc = new Account(Name='Test Account ' + i);
            accounts.add(acc);
        }
        insert accounts;
    }
    
    @isTest static void shouldStartTheControllerAndShowAllAccounts(){
        Test.startTest();
        MessageDescriptionForAccountsController myController = new MessageDescriptionForAccountsController();
        Test.stopTest();

        System.assertEquals(
            15, myController.wrappedAccountList.size(), 
            'The amount of accounts in controller doesnt match with the number in database.');
    }

    @isTest static void shouldMatchTheDescriptionMessageFromWhatIsInDatabase(){
        MessageDescriptionForAccountsController myController = new MessageDescriptionForAccountsController();
        myController.description = 'description';
        myController.wrappedAccountList[0].isAccountSelected = true;

        Test.startTest();
        myController.addDescriptionToSelectedAccounts();
        Test.stopTest();

        List<Message__c> messages = [
            SELECT Description__c
            FROM Message__c
        ];

        System.assertEquals(1, messages.size(), 'There are no messages in database');
        System.assertEquals(
            myController.description, messages[0].Description__c, 
            'The description from controller doesnt match with the one in database.');
    }

    @isTest static void shouldExistMessageForEachSelectedAccount(){
        MessageDescriptionForAccountsController myController = new MessageDescriptionForAccountsController();
        myController.description = 'description';
        myController.wrappedAccountList[0].isAccountSelected = true;
        myController.wrappedAccountList[1].isAccountSelected = true;
        myController.wrappedAccountList[2].isAccountSelected = true;

        Test.startTest();
        myController.addDescriptionToSelectedAccounts();
        Test.stopTest();

        List<AccountMessageAssociation__c> accMessages = [
            SELECT Account__c
            FROM AccountMessageAssociation__c
        ];

        System.assertEquals(3, accMessages.size(), 
        'There are no messages in database.');
        for (Integer i = 0; i < 3; i++) {
            System.assertEquals(
                accMessages[i].Account__c, myController.bindedMessages[i].Account__c, 
                'The ids from database and controller dont match');
        }
    }

    @IsTest
    static void shouldNotInsertMessageSinceItsABlankMessageNorConnectItToTheAccounts(){
        MessageDescriptionForAccountsController myController = new MessageDescriptionForAccountsController();
        myController.description = '';
        myController.wrappedAccountList[0].isAccountSelected = true;

        Test.startTest();
        myController.addDescriptionToSelectedAccounts();
        Test.stopTest();
        
        List<Message__c> messages = [
            SELECT Description__c
            FROM Message__c
        ];

        List<AccountMessageAssociation__c> accMessages = [
            SELECT Account__c
            FROM AccountMessageAssociation__c
        ];

        System.assertEquals(0, messages.size(), 'There are messages in database');
        System.assertEquals(0, accMessages.size(), 'There has been an association between messages and account');
    }

    @IsTest
    static void shouldNotInsertMessageWhenThereAreNoAccountsToAssociateTo(){
        MessageDescriptionForAccountsController myController = new MessageDescriptionForAccountsController();
        myController.description = 'description';

        Test.startTest();
        myController.addDescriptionToSelectedAccounts();
        Test.stopTest();
        
        List<Message__c> messages = [
            SELECT Description__c
            FROM Message__c
        ];

        System.assertEquals(0, messages.size(), 'There are messages in database.');
    }
}
