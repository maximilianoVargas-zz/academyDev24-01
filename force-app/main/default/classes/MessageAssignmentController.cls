public with sharing class MessageAssignmentController {

    private static final Integer INITIAL_ACCOUNTS = 10;

    public List<WrapAccount> wrapAccountList {get; set;}
    public String description {get; set;}
    public Boolean showErrorMessage {get; set;}
    public Boolean showSuccessMessage {get; set;}
     
    public MessageAssignmentController(){
        if(wrapAccountList == null) {
            wrapAccountList = new List<wrapAccount>();
            for(Account a: [SELECT Id, Name, BillingState, Phone FROM Account LIMIT :INITIAL_ACCOUNTS]) {
                wrapAccountList.add(new wrapAccount(a));
            }
        }
        this.showErrorMessage = false;
        this.showSuccessMessage = false;
    }

    public void createMessage() {
        // Search if al least 1 account has been selected
        Boolean atLeastOne = false;
        for (WrapAccount wrapAccount : wrapAccountList) {
            if(wrapAccount.selected) {
                atLeastOne = true;
                break;
            }
        }
        if(!atLeastOne) {
            this.showErrorMessage = true;
            return;
        } else {
            this.showErrorMessage = false;
        }

        // Create the message
        Message__c message = new Message__c(
            Description__c = this.description
        );
        insert message;
        system.debug('Message created');

        // Assign message to Accounts. It is a M-N relationship
        List<Message_Account_Association__c> associations = new List<Message_Account_Association__c>();
        for (WrapAccount wrapAccount : wrapAccountList) {
            if(wrapAccount.selected) {
                Message_Account_Association__c association = new Message_Account_Association__c(
                    Message__c = message.Id,
                    Account__c = wrapAccount.acc.Id
                );
                associations.add(association);
            }
        }
        insert associations;
        system.debug('Message_Account_Associations created');
        this.showSuccessMessage = true;
    }
 
    public class WrapAccount {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
 
        public wrapAccount(Account a) {
            acc = a;
            selected = false;
        }
    }
}
