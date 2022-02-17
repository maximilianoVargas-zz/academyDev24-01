public with sharing class MessageAssignmentController {

    private static final Integer INITIAL_ACCOUNTS = 10;

    public List<WrapAccount> wrapAccountList {get; set;}
    public String description {get; set;}
     
    public MessageAssignmentController(){
        if(wrapAccountList == null) {
            wrapAccountList = new List<wrapAccount>();
            for(Account a: [SELECT Id, Name, BillingState, Phone FROM Account LIMIT :INITIAL_ACCOUNTS]) {
                wrapAccountList.add(new wrapAccount(a));
            }
        }
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
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'At least 1 account must be selected'));
            return;
        }

        // Check if description is empty
        if(string.isBlank(this.description)) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Error,'No description provided'));
            return;
        }

        // Create the message
        Message__c message = new Message__c(
            Description__c = this.description
        );
        insert message;

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
        ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.Confirm,'Success!'));
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
