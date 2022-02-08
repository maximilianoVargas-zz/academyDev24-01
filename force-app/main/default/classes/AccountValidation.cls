public class AccountValidation {
    public static void validateAccount(List<Account> listNewAccounts) {
        List<Account> listAllAccounts = [
            SELECT id, Name, Document_number__c, Identification_type__c
            FROM Account
        ];
        // usar custom levels
        List<Account> listErrorAccounts = new List<Account>();
        for(Account aNewAccount:listNewAccounts){
            for(Account aAccount:listAllAccounts){
                if(aNewAccount.Document_number__c == aAccount.Document_number__c
                   && aNewAccount.Identification_type__C == aAccount.Identification_type__C){
                        aNewAccount.addError('Cannot create account with same id type and number');
                    }
                    
            }
        }
        


        }
    }