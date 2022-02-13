public with sharing class AccountValidation {
    public static Boolean validateAccount(Account anAccount){
        String identificationType = anAccount.Identification_type__c;
        String documentNumber = anAccount.Document_number__c;

        List<Account> checkAccount = [
            SELECT Id, Identification_type__c, Document_number__c
            FROM Account
            WHERE Document_number__c = :documentNumber
                AND Identification_type__c = :identificationType
            LIMIT 1
        ];
        //if account exists, returns false. Account not validated
        if(checkAccount.size() == 1){
            return false;
        }else {
            return true;
        }
    }
}