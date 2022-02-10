/*Triggers Practice  (1 Hour)
Create a Class called AccountValidation, which must contain the following method:
validateAccount. You must receive the new accounts and validate whether another account with
the same document type and document number already exists. If any account is found, an error 
message must be added.
Create a trigger on the account object named AccountTrigger, which must call the validateAccount
 method of the AccountValidation class each time an account is created or updated
Create a box-type field, called create opportunity
Create a class called AccountManage, which must contain the following method:
createOpportunity. You must receive the accounts and for each account that has the create 
opportunity field equal to true, you must create a new record in the opportunity object 
associated with the account. The created sales opportunity must have the following values:
Name = "Opportunity" + account name + current date
Stage = "Prospection”
ClosedDate = current date + 30 days

 */
public class AccountValidation {
    public static void validateAccount(List<Account> listNewAccounts) {
        List<Account> listAllAccounts = [
            SELECT id, Name, Document_number__c, Identification_type__c
            FROM Account
        ];

        List<Account> listErrorAccounts = new List<Account>();
        for(Account aNewAccount:listNewAccounts){
            for(Account aAccount:listAllAccounts){
                if(aNewAccount.Document_number__c == aAccount.Document_number__c
                   && aNewAccount.Identification_type__c == aAccount.Identification_type__c){
                        aNewAccount.addError('Cannot create account with same id type and number');
                }
                    
            }
        }
        


    }
}