public class AccountMessageController {
    
    public List<wrapAccount> wrapAccountList {get; set;}
    public List<Account> selectedAccounts{get;set;}
    public string message {get; set;}

    public AccountMessageController() {
        if(wrapAccountList == null) {
            wrapAccountList = new List<wrapAccount>();
            for(Account a: [select Id, Name,BillingState, Website, Phone from Account limit 10]) {
                // As each Account is processed we create a new wrapAccount object and add it to the wrapAccountList
                wrapAccountList.add(new wrapAccount(a));
            }
        }        
    }

    public void SendMessage()
    {
        //System.debug(message);
        selectedAccounts = new List<Account>();
 
        for(wrapAccount wrapAccountObj : wrapAccountList) {
            if(wrapAccountObj.selected == true) {
                selectedAccounts.add(wrapAccountObj.acc);
            }
        }

        Message__c anMessage = new Message__c();
        anMessage.Name = message.left(80);
        anMessage.Description__c = message.left(255);
        Insert(anMessage);

        List<Account_Message__c> accountsMessages = new List<Account_Message__c>();
        Account_Message__c anAccountMessage;
        for (Account anAccount : selectedAccounts) {
            anAccountMessage = new Account_Message__c();
            anAccountMessage.Name = anAccount.Name + ' - ' + anMessage.Description__c;
            anAccountMessage.Cuenta__c = anAccount.Id;
            anAccountMessage.Message__c = anMessage.Id;
            accountsMessages.add(anAccountMessage);
        }        
        Insert(accountsMessages);
    }

    // This is our wrapper/container class. A container class is a class, a data structure, or an abstract data type whose instances are collections of other objects. In this example a wrapper class contains both the standard salesforce object Account and a Boolean value
    public class wrapAccount {
        public Account acc {get; set;}
        public Boolean selected {get; set;}
 
        //This is the contructor method. When we create a new wrapAccount object we pass a Account that is set to the acc property. We also set the selected value to false
        public wrapAccount(Account a) {
            acc = a;
            selected = false;
        }
    }    
    
}