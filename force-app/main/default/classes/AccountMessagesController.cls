public with sharing class AccountMessagesController {

    public List<AccountSelected> accountsSelected {get; set;}
    public String description {get; set;}

    public List<AccountSelected> getAccounts() {

        List<Account> accounts = [
            SELECT Id, Name 
            FROM Account
       	];
          
        accountsSelected = new List<AccountSelected>();

        for (Account anAccount : accounts) {
            AccountSelected accountSelected = new AccountSelected(false, anAccount);
            accountsSelected.add(accountSelected);
        }
        return accountsSelected;
    }

    public void saveMessage() {

        Message__c message = new Message__c();
        message.Description__c = description;
        description = null;

        insert message;

        List<AccountMessageAssociation__c> accountsMessages = new List<AccountMessageAssociation__c>();

        for (AccountSelected anAccountSelected : accountsSelected) {
            if (anAccountSelected.selected) {
                AccountMessageAssociation__c anAccountMessageAssociation = new AccountMessageAssociation__c();
                anAccountMessageAssociation.Account__c = anAccountSelected.account.Id;
                anAccountMessageAssociation.Message__c = message.Id;
                anAccountSelected.selected = false;
                accountsMessages.add(anAccountMessageAssociation);
            }
        }

        insert accountsMessages;

    } 
}
