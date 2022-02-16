public with sharing class AccountMessageController {

    public list<wrapperAccount> wrapperAccounts {get; set;}
    public string messageDescription {get; set;}

    public AccountMessageController() {
        this.wrapperAccounts = new List<wrapperAccount>();

        for (Account anAccount : 
            [
                SELECT Id, Name
                FROM Account
            ]) {
            this.wrapperAccounts.add(
                new wrapperAccount(anAccount)
            );
        }
    }

    public void save(){
        if (!string.isBlank(this.messageDescription)) {
            Savepoint sp = Database.setSavepoint();
            Message__c message = new Message__c(
                Description__c = this.messageDescription
            );
            insert message; 
            List<Account> accounts = new List<Account>();
            for (wrapperAccount aWrapperAccount : this.wrapperAccounts) {
                if (aWrapperAccount.isChecked) {
                    Accounts.add(aWrapperAccount.anAccount);
                }
            }
            if (accounts.isEmpty()) {
                Database.rollback(sp);
            }else {
                List<account_message__c> accountMessages = new List<account_message__c>();
            for (Account anAccount : accounts) {
                accountMessages.add(
                    new account_message__c(
                        Name = anAccount.Name,
                        Account__c = anAccount.id,
                        message__c = message.Id
                    )
                );
            }

                insert accountMessages;
            }
            
            
        }
        
    }

    public class wrapperAccount{
        public Account anAccount;
        public Boolean isChecked;
        public wrapperAccount(Account anAccount){
            this.anAccount = anAccount;
            this.isChecked = false;
        }
    }
}