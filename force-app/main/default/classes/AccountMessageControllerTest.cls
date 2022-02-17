@isTest
public with sharing class AccountMessageControllerTest {
    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            accounts.add(
                new Account(
                    Name = 'Account Name: '+i
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

        System.assertEquals(
            10, myController.wrapperAccounts.size(), 
        'the number of wrapperAccount not mach with the Accounts in data base'
        );
        
    }

    @IsTest
    static void whenCallASaveFunctionOneMessageIsInsertedInDataBase(){
        
        AccountMessageController myController = new AccountMessageController();
        myController.messageDescription = 'description';
        myController.wrapperAccounts[0].isChecked = true;

        Test.startTest();
        myController.save();
        Test.stopTest();

        List<Message__c> messages = [
            SELECT Description__c
            FROM Message__c
        ];
        
        System.assertEquals(1, messages.size(), 'is not created a message in database');
        System.assertEquals(
            myController.messageDescription, 
            messages[0].Description__c, 
            'the description in controler not mach with description in message'
        );
    }

    @IsTest
    static void whenCallASaveFunctionOneAccountMessageIsInsertedForEveryAccountSelected(){
        
        AccountMessageController myController = new AccountMessageController();
        myController.messageDescription = 'description';
        myController.wrapperAccounts[0].isChecked = true;
        myController.wrapperAccounts[1].isChecked = true;
        myController.wrapperAccounts[2].isChecked = true;

        Test.startTest();
        myController.save();
        Test.stopTest();

        list<Account_Message__c> accountMessages = [
            SELECT Account__c
            FROM Account_Message__c
        ];

        System.assertEquals(3, accountMessages.size(), 'in database the account Message was not created');
        for (Integer i = 0; i < 3; i++) {
            System.assertEquals(myController.wrapperAccounts[i].anAccount.id, accountMessages[i].Account__c, 'the account ');
        }
    }
}