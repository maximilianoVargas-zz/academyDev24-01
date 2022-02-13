public with sharing class AccountValidation {
    public static void validateAccount(List<Account> accounts){

        Map<String,Account> accountsByDocumentNumber = new Map<String,Account>();
        for (Account acc : accounts){
            accountsByDocumentNumber.put(acc.Document_Number__c, acc);
        }

        List<Account> repeatedAccounts = [
            SELECT Document_Number__c, Conflict_Error__c
            FROM Account
            WHERE Document_Number__c 
            IN :accountsByDocumentNumber.keySet()
        ];

        for (Account acc2 : repeatedAccounts){
            acc2.Conflict_Error__c = 'ERROR: An account with this Document Number and Type Already Exits';
        }

        update repeatedAccounts;
    }

}