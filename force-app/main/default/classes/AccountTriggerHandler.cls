public with sharing class AccountTriggerHandler {
    public static List<Account> AccountTriggerValidateAccount(List<Account> accounts){
        return AccountValidation.validateAccount(accounts);
    }
}