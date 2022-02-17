public with sharing class AccountMessageController {

    public list<wrapperAccount> wrapperAccounts {get; set;}
    public string messageDescription {get; set;}

    public AccountMessageController() {
        this.wrapperAccounts = new List<wrapperAccount>();

        for (Account anAccount : 
            [
                SELECT Id, Name
                FROM Account
                LIMIT 5
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
            }
            
            else {
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
                apexPages.addmessage(new apexpages.message(apexpages.severity.Confirm, 'Saved Correctly'));
                ResetValues();
            }    
        }

        else{
            apexPages.addmessage(new apexpages.message(apexpages.severity.error, 'No Checked any Account'));
        }
        
    }

    public class wrapperAccount{
        public Account anAccount {get;set;}
        public Boolean isChecked {get;set;}

        public wrapperAccount(Account anAccount){
            this.anAccount = anAccount;
            this.isChecked = false;
        }
    }

    private void ResetValues() {
        for(wrapperAccount aWrapperAccount : wrapperAccounts) {
            aWrapperAccount.isChecked = false;
        }
        messageDescription='';
    }
}