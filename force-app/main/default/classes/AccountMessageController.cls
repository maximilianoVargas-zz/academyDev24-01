public class AccountMessageController {
    
    private List<Account> selectedAccounts;
    private List<WrapperAccount> wrapperAccounts;
    public Message__c message {get;set;}
    
    public AccountMessageController() {
        message = new Message__c();
        selectedAccounts = new List<Account>();
        wrapperAccounts = new List<WrapperAccount>();
    }
    
    public List<WrapperAccount> getAccounts() {
        wrapperAccounts.clear();
        List<Account> accounts = [
        	SELECT Id, Name
            FROM Account
            LIMIT 10
        ];
        for (Account anAccount : accounts)
            wrapperAccounts.add(new WrapperAccount(anAccount));
        return wrapperAccounts;
    }
    
    public void sendMessage() {
	    selectedAccounts = new List<Account>();
        for(WrapperAccount wrapAccountObj : wrapperAccounts) {
            if(wrapAccountObj.selected == true) {
                selectedAccounts.add(wrapAccountObj.account);
            }
        }
        insert message;
        List<AccountMessage__c> accountMessages = new List<AccountMessage__c>();
        for (Account anAccount : selectedAccounts) {
            AccountMessage__c anAccountMessage = new AccountMessage__c();
            anAccountMessage.Account__c = anAccount.Id;
            anAccountMessage.message__c = message.Id;
            accountMessages.add(anAccountMessage);
        }
        insert accountMessages;
    }
    
}