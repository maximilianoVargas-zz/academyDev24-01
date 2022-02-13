public with sharing class AccountTriggerHandler {
    public static List<Account> AccountTriggerInsertAccount(List<Account> accounts){
        for(Account anAccount : accounts){
            if(AccountValidation.validateAccount(anAccount) == false){
                anAccount.addError('Account Already Exists');
            }
        }
        return accounts;
    }
    public static List<Account> AccountTriggerUpdateAccount(List<Account> accounts){
        for(Account anAccount : accounts){
            if(AccountValidation.validateAccount(anAccount) == false){
                anAccount.addError('Account Already Has those values');
            }
        }
        return accounts;
    }
}
