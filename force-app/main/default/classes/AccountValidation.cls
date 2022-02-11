public with sharing class AccountValidation {
    public static void validateAccount(List<Account> accounts) {
        for (Account anAccount:accounts){
            Account existingAccount = consultAccount(anAccount.Identification_type__c,anAccount.Document_number__c);
            if (existingAccount != null){
                anAccount.addError('The account already exist.');
            }
        }        
    }

    private static Account consultAccount(String documentType, Decimal documentNumber){
        try{
            return [
                SELECT Id
                FROM Account 
                WHERE Identification_type__c = :documentType 
                AND Document_number__c = :documentNumber
                WITH SECURITY_ENFORCED
                LIMIT 1
            ];
        } catch(Exception e){
            return null;
        }
    }    
}