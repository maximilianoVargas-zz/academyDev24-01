public with sharing class AccountTriggerHandler {
    public static void validateAccount(List<Account> newAccounts){

        List<String> combinedValues = new List<String>();

        for(Account anAccount : newAccounts){
            combinedValues.add(anAccount.Token__c);
        }

        List<Account> accounts = [
            SELECT Id
            FROM Account
            WHERE Token__c IN :combinedValues
        ];

        if(accounts.size() > 0){
            throw new MyException('An account with the same document number and identification type already exists');
        }
    }
}