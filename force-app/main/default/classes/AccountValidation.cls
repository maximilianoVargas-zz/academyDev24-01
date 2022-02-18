public with sharing class AccountValidation {
    public static void validateAccount(List<Account> accounts){
        Map<String,Account> accountsByDocumentNumber=new Map<String,Account>();

        for (Account anAccount : accounts) {
            if(anAccount.DocumentNumber__c!=null && anAccount.IdentificationType__c!=null){
                accountsByDocumentNumber.put(anAccount.DocumentNumber__c, anAccount);
            }
        }

        List<Account> existingAccounts= [
            SELECT Id,DocumentNumber__c,IdentificationType__c 
            FROM Account 
            WHERE DocumentNumber__c IN :accountsByDocumentNumber.keySet()
        ];

        if (existingAccounts.size()>0) {
            for (Account anAccount : accounts) {
                Account foundAccount=accountsByDocumentNumber.get(anAccount.DocumentNumber__c);
                if (foundAccount!=null) {
                    if (anAccount.DocumentNumber__c == foundAccount.DocumentNumber__c && anAccount.IdentificationType__c == foundAccount.IdentificationType__c ) {
                        anAccount.addError('Document already exists');
                    }
                }
            }
        }
    }

    public static void createOpportunity(List<Account> accounts){
        for (Account anAccount : accounts)  {
            if(anAccount.opportunity__c==true){
                Opportunity opp=new Opportunity();
                opp.AccountId=anAccount.Id;
                opp.Name='Opportunity'+anAccount.Name+System.today();
                opp.StageName='Prospection';
                opp.CloseDate=System.today().addMonths(1);
                insert opp;
            }
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