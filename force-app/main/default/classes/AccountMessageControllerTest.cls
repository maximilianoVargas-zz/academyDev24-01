@isTest
public with sharing class AccountMessageControllerTest {
    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            accounts.add(
                new Account(
                    Name = 'Name '+ i
                )
            );
        }

        insert accounts;
    }

    @IsTest
    static void whenInitializeAccountMessageControllerTheWrapperListGetTheSameSizeOfTheAccountsInDataBase(){
        
        Test.startTest();
        AccountMessageController myController = new AccountMessageController();
        Test.stopTest();

        System.assertEquals(10, myController.wrapperAccounts.size(),'the number of wrapperAccount not mach with the Accounts in data base');
        
    }

    @IsTest
    static void whenCallASaveFunctionOneMessageIsInsertedInDataBase(){
        
        AccountMessageController myController = new AccountMessageController();
        myController.messageDescription = 'Description';
        myController.wrapperAccounts[0].isSelected = true;

        Test.startTest();
        myController.SaveAccountMessage();
        Test.stopTest();

        List<Message__c> messages = [
            SELECT Description__c
            FROM Message__c
        ];
        
        System.assertEquals(1, messages.size(), 'The message is not inserted in Message DB');
        System.assertEquals(
            myController.messageDescription, 
            messages[0].Description__c, 
            'the description in controller does not macth with description in Message DB'
        );
    }

    @IsTest
    static void whenCallASaveFunctionOneAccountMessageIsInsertedForEveryAccountSelected(){
        
        AccountMessageController myController = new AccountMessageController();
        myController.messageDescription = 'Description';
        myController.wrapperAccounts[0].isSelected = true;
        myController.wrapperAccounts[1].isSelected = true;
        myController.wrapperAccounts[2].isSelected = true;

        Test.startTest();
        myController.SaveAccountMessage();
        Test.stopTest();

        list<Account_Message__c> accountMessages = [
            SELECT Account__c
            FROM Account_Message__c
        ];

        System.assertEquals(3, accountMessages.size(), 'In database the Account Messages were not created');
        for (Integer i = 0; i < 3; i++) {
            System.assertEquals(myController.wrapperAccounts[i].anAccount.id, accountMessages[i].Account__c, 
            'The account in Account Meesages does not match with the Account in Messages');
        }
    }

    @IsTest
    static void whenCallASaveFunctionWithNoAccountSelectedToInsertedMessage(){
        
        AccountMessageController myController = new AccountMessageController();
        myController.messageDescription = 'Description';

        Test.startTest();
        myController.SaveAccountMessage();
        Test.stopTest();

        list<Account_Message__c> accountMessages = [
            SELECT Account__c
            FROM Account_Message__c
        ];

        System.assertEquals(0, accountMessages.size(), 'There is no Accounts to selected to send the message');

    }

    @IsTest
    static void whenCallASaveFunctionWithNoMessageSetToAccountsSelected(){
        
        AccountMessageController myController = new AccountMessageController();
        myController.wrapperAccounts[0].isSelected = true;
        myController.wrapperAccounts[1].isSelected = true;
        myController.wrapperAccounts[2].isSelected = true;
        
        Test.startTest();
        myController.SaveAccountMessage();
        Test.stopTest();

        System.assertEquals(null, myController.messageDescription, 'There is no Message to insert in the selected accounts. ');

    }
}