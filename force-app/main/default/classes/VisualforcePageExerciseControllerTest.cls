@isTest
public class VisualforcePageExerciseControllerTest {
	@isTest
    static void checkIfMessageIsCreated(){
        List<Account> accounts = new List<Account>();
        List<Id> accountIds = new List<Id>();
        accounts.add(new Account(
        	Name = 'TestAccount1',
            MessageBody__c = 'TestMessage'
        ));
        accounts.add(new Account(
        	Name = 'TestAccount2',
            MessageBody__c = null
        ));
        accounts.add(new Account(
        	Name = 'TestAccount3',
            MessageBody__c = ''
        ));
        insert accounts;
        
        for(Account anAccount : accounts){
            accountIds.add(anAccount.Id);
        }
        
        Test.startTest();
        VisualforcePageExerciseController accountList = new VisualforcePageExerciseController();
        accountList.saveMessage();
        Test.stopTest();
        
        List<Message__c> messages = [
            SELECT Id, Account__c, Description__c
            FROM Message__c
            LIMIT 100
        ];
        System.debug(messages);
        System.assertEquals(1, messages.size(), 'Something went wrong when creating a message for an account');
    }
}