public with sharing class AccountValidation {
    public static void validateAccount(List<Account> accounts){
        for(Integer i=0; i<accounts.size(); i++){
            for(Integer j=i+1; j<accounts.size(); j++){
                if(accounts[i].IdentificationType__c==accounts[j].IdentificationType__c
                && accounts[i].DocumentNumber__c==accounts[j].DocumentNumber__c){
                    System.debug('Document already exists !!!');
                    accounts[i].addError('Document already exists !!!');
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