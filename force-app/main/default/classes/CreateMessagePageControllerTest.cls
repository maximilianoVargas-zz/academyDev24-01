@isTest
public with sharing class CreateMessagePageControllerTest {

    @TestSetup
    static void makeData(){
        List<Account> newAccounts = new List<Account>();
        for(Integer i = 0; i<20; i++){
            newAccounts.add(new Account(
                Name = 'Test ' + i
            ));            
        }
        insert newAccounts;
    }
   
    @isTest
    public static void whenCreateMessagePageIsLoaded(){
        Test.startTest();
        CreateMessagePageController aPage = new CreateMessagePageController();               
        Test.stopTest();

        System.assertEquals(20, aPage.WrapperAccounts.size());
    }

    @isTest
    public static void whenAMessageIsCreated(){
        CreateMessagePageController aPage = new CreateMessagePageController();               
        Test.startTest();
        aPage.saveMessage('Test');
        Test.stopTest();

        Message__c aMessage = [
            SELECT Text_Message__c 
            FROM Message__c 
            WHERE Text_Message__c = 'Test'
        ];

        System.assertEquals('Test', aMessage.Text_Message__c, 'El mensaje esperado no aparece en la Base de datos');
    }


    @isTest
    public static void whenSomeoneSaveAMessagewithAccountsMessageChecked(){
        CreateMessagePageController aPage = new CreateMessagePageController();     
        Integer par = 0;
        Map<Id, Account> accountById = new Map<Id, Account>();
        for(CreateMessagePageController.WrapperAccount anAccount : aPage.WrapperAccounts){
            if(math.mod(par,2)==0){
                anAccount.isSelected = true;
                accountById.put(anAccount.anAccount.Id, anAccount.anAccount);
            }
            par++;
        }

        Test.startTest();
        aPage.saveMessageInAccounts();
        Test.stopTest();

        List<Account_Message__c> accountMessages = [
            SELECT Id
            FROM Account_Message__c
            WHERE Account__c IN :accountById.keySet()
        ];

        System.assertEquals(10, accountMessages.size(), 'La cantidad de mensajes en la cuentas no corresponde al esperado');

    }

}
