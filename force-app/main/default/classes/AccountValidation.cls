public with sharing class AccountValidation {
    public static void validateAccount(Account anAccount) {
        List<Account> accounts = [
            SELECT Id, Name, Identification_type__c, Document_number__c
            FROM Account
            WHERE Identification_type__c = :anAccount.Identification_type__c
            AND Document_number__c = :anAccount.Document_number__c
        ];
        if(!accounts.isEmpty()) {
            anAccount.addError('The account already exists');
            System.debug(anAccount);
        }
    }
}