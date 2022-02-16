public class MessageDescriptionForAccountsController {

    public List<WrapAccount> wrappedAccountList {get; set;}
    public List<AccountMessageAssociation__c> bindedMessages {get; set;}
    public String description {get; set;}

    public MessageDescriptionForAccountsController() {
        if (wrappedAccountList == null){
            wrappedAccountList = new List<WrapAccount>();
            List<Account> accounts = [
                SELECT Name, Phone, Type
                FROM Account
            ];
            for (Account a : accounts){
                wrappedAccountList.add(new WrapAccount(a));
            }
        }
        if (bindedMessages == null){
            bindedMessages = new List<AccountMessageAssociation__c>();
            List<AccountMessageAssociation__c> accMsgAsso = [
                SELECT Account__c, Message__c
                FROM AccountMessageAssociation__c
            ];
            for (AccountMessageAssociation__c anAMA : accMsgAsso){
                bindedMessages.add(anAMA);
            }
        }
    }

    public void addDescriptionToSelectedAccounts(){
        if (string.isNotBlank(this.description)) {
            Savepoint sp = Database.setSavepoint();
            List<AccountMessageAssociation__c> bindedToInsert = new List<AccountMessageAssociation__c>();
            Message__c aMessage = new Message__c(Description__c=description);
            insert aMessage;

            for (WrapAccount wa : wrappedAccountList){
                if (wa.isAccountSelected){
                    AccountMessageAssociation__c anAMA = new AccountMessageAssociation__c(
                                                                Account__c=wa.associatedAccount.Id, 
                                                                Message__c=aMessage.Id);
                    bindedMessages.add(anAMA);
                    bindedToInsert.add(anAMA);
                }
            }
            if (bindedToInsert.isEmpty()) {
                Database.rollback(sp);
                ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Por favor seleccionar una cuenta.'));
            } else {
                insert bindedToInsert;   
            }
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.severity.ERROR, 'Descripción no puede estar vacío.'));
        }
        
        
    }

    public class WrapAccount{
        public Account associatedAccount {get; set;}
        public Boolean isAccountSelected {get; set;}

        public WrapAccount(Account anAccount){
            associatedAccount = anAccount;
            isAccountSelected = false;
        }
    }
}