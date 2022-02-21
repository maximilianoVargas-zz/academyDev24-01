public with sharing class CreateMessagePageController {
    
    public List<WrapperAccount> WrapperAccounts {get; set;}
    public String frontMessage{get; set;}

    public CreateMessagePageController() {
        WrapperAccounts = new List<WrapperAccount>();
        for(Account anAccount : [SELECT Name FROM Account ORDER BY Id DESC LIMIT 20]){
            WrapperAccounts.add(new WrapperAccount(anAccount));
        }
        frontMessage = '';
    }

    public void saveMessageInAccounts(){
        Message__c newMessage = saveMessage(frontMessage);
        List<Account_Message__c> accountMessages = new List<Account_Message__c>();
        for(WrapperAccount anWrapperAccount: WrapperAccounts){
            if(anWrapperAccount.isSelected){
                accountMessages.add(
                    new Account_Message__c(
                        Account__c = anWrapperAccount.anAccount.Id,
                        Message__c = newMessage.Id
                    )
                );
            }
        }

        insert accountMessages;

    }

    public Message__c saveMessage(String inputMessage){
        Message__c newMessage = new Message__c(
            Text_Message__c = inputMessage
        );

        insert newMessage;

        return newMessage;
    }

    public class WrapperAccount{
        public Account anAccount{get;set;}
        public Boolean isSelected{get;set;}

        public WrapperAccount(Account anAccount){
            this.anAccount = anAccount;
            this.isSelected = false;
        }
    }
}
