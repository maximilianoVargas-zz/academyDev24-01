public with sharing class AsignMessageController {
    public List<AccountWrapper> wrappers {get; set;}
    public Message__c message {get; set;}
    public List<AccountMessage__c> accountsMessages {get; set;}
    
    public AsignMessageController(){
        List<Account> accounts = [
            SELECT Id, Name
            FROM Account
        ];  
        
        this.wrappers = new List<AccountWrapper>();
        for (Account anAccount : accounts) {
            this.wrappers.add(new AccountWrapper(anAccount, false));
        }
        this.message = new Message__c(Description__c = '');
        this.accountsMessages = new List<AccountMessage__c>();
    }

    public void asignMessages(){
        Savepoint sp = Database.setSavepoint();
        Message__c message = new Message__c(Description__c = this.message.Description__c);
        if (message.Description__c == '') {
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Message description must not be empty'));
        } else {
            insert message;
            Boolean theAreTrueWrappers = false;
            List<Account> accountsToAddMessage = new List<Account>();
            List<AccountMessage__c> accountsMessages = new List<AccountMessage__c>();
    
            for (AccountWrapper wrapper : this.wrappers) {
                if (wrapper.edit) {
                    theAreTrueWrappers = true;
                    accountsToAddMessage.add(wrapper.account);
                }
            }
            if (!theAreTrueWrappers) {
                Database.rollback(sp);
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'There are not accounts selected to set the message'));
            } else{
                for (Account anAccount : accountsToAddMessage) {
                    accountsMessages.add(new AccountMessage__c(Account__c = anAccount.Id, Message__c = message.Id));
                }
                insert accountsMessages;
                this.message = new Message__c(Description__c = '');
                ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Message added'));
            }
        }        
    }

    public class AccountWrapper{
        public Account account {get; set;}
        public Boolean edit {get; set;}

        public AccountWrapper(Account anAccount, Boolean edit){
            this.account = anAccount;
            this.edit = edit;
        }
    }
}
