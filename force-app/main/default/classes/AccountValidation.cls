public with sharing class AccountValidation {
    public static List<Account> validateAccount(List<Account> accounts){

        Map<String,Account> accountsByDocumentNumber = new Map<String,Account>();
        for (Account anAccount : accounts){
            if(anAccount.Identification_type__c !=null && anAccount.Document_number__c !=null){
                accountsByDocumentNumber.put(anAccount.Document_number__c, anAccount);
            }
        }

        List<Account> checkAccount = [
            SELECT Id, Identification_type__c, Document_number__c
            FROM Account
            WHERE Document_number__c IN :accountsByDocumentNumber.keySet()
            LIMIT 200
        ];

        Map<String,String> idTypeByDocumentNumber = new Map<String,String>();
        for(Account anAccount : checkAccount){
            idTypeByDocumentNumber.put(anAccount.Document_number__c, anAccount.Identification_type__c);
        }

        for(Account anAccount : accounts){
            if(idTypeByDocumentNumber.get(anAccount.Document_number__c) == anAccount.Identification_type__c){
                anAccount.addError('Account Already Exists');
            }
        }
        return accounts;   
    }
}