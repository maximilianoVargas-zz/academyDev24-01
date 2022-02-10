public with sharing class AccountValidation {
    public static void validateAccount(List<Account> accounts){
        List<Account> existingAccounts= [select Id,DocumentNumber__c,IdentificationType__c from Account];
        Map<String,Account> accountsByDocumentNumber=new Map<String,Account>();

        for (Account account : existingAccounts) {
            if(account.DocumentNumber__c!=null && account.IdentificationType__c!=null){
                accountsByDocumentNumber.put(account.DocumentNumber__c, account);
            }
        }

        for (Account account : accounts) {
            Account acc=accountsByDocumentNumber.get(account.DocumentNumber__c);
            System.debug('acc: '+ acc);
            if (acc!=null) {
                if (account.DocumentNumber__c == acc.DocumentNumber__c && account.IdentificationType__c == acc.IdentificationType__c ) {
                    account.addError('Document already exists');
                }
            }
        }
    }

    public static void createOpportunity(Account account){
        if(account.opportunity__c==true){
            Opportunity opp=new Opportunity();
            opp.AccountId=account.Id;
            opp.Name='Opportunity'+account.Name+System.today();
            opp.StageName='Prospection';
            opp.CloseDate=System.today().addMonths(1);
        }
    }
    /*
    Triggers Practice  (1 Hour)
Create a Class called AccountValidation, which must contain the following method:
validateAccount. You must receive the new accounts and validate whether another account with the same document type and document number already exists. If any account is found, an error message must be added.
Create a trigger on the account object named AccountTrigger, which must call the validateAccount method of the AccountValidation class each time an account is created or updated

Create a box-type field, called create opportunity
Create a class called AccountManage, which must contain the following method:
createOpportunity. You must receive the accounts and for each account that has the create opportunity field equal to true, you must create a new record in the opportunity object associated with the account. The created sales opportunity must have the following values:
Name = "Opportunity" + account name + current date
Stage = "Prospection”
ClosedDate = current date + 30 days
    */
}