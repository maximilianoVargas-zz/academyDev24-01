public with sharing class AccountMessageController {

    public List<WrapperAccount> wrapperAccounts {get;set;}
    public string messageDescription {get; set;} 

    public AccountMessageController (){
        this.wrapperAccounts = new List<WrapperAccount>();

        for(Account anAccount : [
            SELECT Id,Name 
            FROM Account
            ]){
                this.wrapperAccounts.add(
                    new WrapperAccount(anAccount)
                );
            }
    }

    public void SaveAccountMessage(){
        if(!string.isBlank(messageDescription)){
            Savepoint sp = Database.setSavepoint();
            Message__c aMessage = new Message__c(
                Description__c = messageDescription
            );
            insert aMessage;
            
            List<Account> accounts = new List<Account>();
            for(WrapperAccount aWrapperAccount : this.wrapperAccounts){
                if(aWrapperAccount.isSelected){
                    accounts.add(aWrapperAccount.anAccount);
                }
            }

            if(!accounts.isEmpty()){
                    List<Account_Message__c> accountMessages = new List<Account_Message__c>();
                    for(Account anAccount : accounts){
                        accountMessages.add( 
                            new Account_Message__c (
                                Name = anAccount.Name,
                                Account__c = anAccount.Id,
                                Message__c = aMessage.Id
                            ) 
                        );
                    }

                    insert accountMessages;
                    ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'The message was successfully inserted for the selected accounts.'));

            }else{
                Database.rollback(sp);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'No accounts selected. Please choose the accounts to set a message.'));
            }
        }else{
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.Error, 'The message is empty. Please set a message to insert.'));
        }
    }
}

