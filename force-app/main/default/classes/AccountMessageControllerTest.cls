@isTest
public with sharing class AccountMessageControllerTest {

    @TestSetup
    static void makeData(){
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<10; i++) {
            accounts.add(new Account(
                Name = 'Name ' + i
                )
            );
        }
        Insert accounts;
    }

    @isTest
    static void whenInitializeAccountMessageControllerTheWrapperListGetTheSameSizeOfTheAccountsInDataBase(){
        Test.startTest();
        AccountMessageController controller = new AccountMessageController();        
        Test.stopTest();

        System.assertEquals(10,controller.wrapAccountList.size(), 'The number of wrapAccountList not match with the Accounts in data base.');
    }

    @isTest
    static void whenCallSaveFunctionOneMessageIsInsertInDatabase()
    {
        AccountMessageController controller = new AccountMessageController();
        controller.message = 'Mensaje';
        controller.wrapAccountList[0].selected = true;
        
        Test.startTest();
        controller.SendMessage();
        Test.stopTest();

        List<Message__c> messages = [
            SELECT Description__c
            FROM Message__c
        ];

        System.assertEquals(1, messages.size(),'Is not created in the database');
        System.assertEquals(
            Controller.message, 
            messages[0].Description__c, 
            'the description in controler not mach with description in message'
        );
    }

    @isTest
    public static void whenCallSaveFunctionOneAccountMessageIsInsertedForEveryAccountSelected()
    {
        AccountMessageController controller = new AccountMessageController();
        controller.message = 'Mensaje';
        controller.wrapAccountList[0].selected = true;
        controller.wrapAccountList[1].selected = true;
        controller.wrapAccountList[2].selected = true;

        Test.startTest();
        controller.SendMessage();
        Test.stopTest();

        List<Account_Message__c> accountMessages = [SELECT Cuenta__c FROM Account_Message__c];
        System.assertEquals(3,accountMessages.size(), 'in database the account Message was not created');
        for(Integer i=0; i<3; i++){
            System.assertEquals(controller.wrapAccountList[i].acc.Id, accountMessages[i].Cuenta__c, 'The account is not created in the account_message');            
        }
    }

}
