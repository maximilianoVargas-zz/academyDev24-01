public with sharing class AccountValidation {
    public static void validateAccount(List<Account> accountsToValidate){
        for (Account anAccount : accountsToValidate){
            List<Account> accountsMatching = [
                SELECT Id 
                FROM Account
                WHERE Identification_Type__c=:anAccount.Identification_Type__c 
                AND Document_Number__c=:anAccount.Document_Number__c
                ];
            if (!accountsMatching.isEmpty()){
                anAccount.addError('Cuenta ya existente en base de datos!');
            }
        }
    }
}