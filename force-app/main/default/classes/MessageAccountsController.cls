public with sharing class MessageAccountsController {

    public List<WrapAccount> wrapAccountList {get; set;}
    public List<Account> selectedAccounts {get; set;}
    public String message {get; set;}
    
    public MessageAccountsController() {
        wrapAccountList = new List<WrapAccount>();
        for(Account anAccount : [SELECT Id, Name FROM Account LIMIT 20]) {
            wrapAccountList.add(new WrapAccount(anAccount));
        }
    }

    public void processAccountSelected() {
        selectedAccounts = new List<Account>();
        for(WrapAccount aWrap : wrapAccountList) {
            if(aWrap.selected) {
                selectedAccounts.add(aWrap.acc);
            }
        }
    }

    public void save() {
        if(message != null && !message.equals('')) {
            if(selectedAccounts != null && !selectedAccounts.isEmpty()) {
                Message__c aMessage = new Message__c( Name = message);
                insert aMessage;
                List<MessageInAccount__c> messages = new List<MessageInAccount__c>();
                for(Account anAccount : selectedAccounts) {
                    MessageInAccount__c aMessageInAccount = new MessageInAccount__c(Account__c = anAccount.Id, Message__c = aMessage.Id);
                    messages.add(aMessageInAccount);
                }
                insert messages;
                selectedAccounts = new List<Account>();
                message = '';
                cleanWrapSelected();
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.CONFIRM, 'Datos guardados correctamente'));
            } else {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Debe seleccionar cuentas para agregarles el mensaje'));
            }
        } else {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Por favor agregue un valor al mensaje'));
        }
    }

    private void cleanWrapSelected() {
        for(WrapAccount aWrap : wrapAccountList) {
            aWrap.selected = false;
        }
    }

    public class WrapAccount {

        public Account acc {get; set;}
        public Boolean selected {get; set;}

        public WrapAccount(Account anAccount) {
            acc = anAccount;
            selected = false;
        }

    }

}
