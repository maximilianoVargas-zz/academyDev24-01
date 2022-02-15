public with sharing class AccountValidation {

    public static void validateAccount (List<Account> accounts) {

        List<String> documents = new List<String>();
        for(Account anAccount : accounts) {
            documents.add(anAccount.Document_number__c);
        }

        Map<String, Account> oldAccountsByDocAndType = new Map<String, Account>();

        List<Account> oldAccounts = [
            SELECT Id, Name, Identification_type__c, Document_number__c
            FROM Account 
            WHERE Document_number__c IN :documents
        ];

        for(Account anAccount : oldAccounts) {
            String key = anAccount.Identification_type__c + '-' + anAccount.Document_number__c;
            oldAccountsByDocAndType.put(key, anAccount);
        }

        for(Account anAccount : accounts) {

            String key = anAccount.Identification_type__c + '-' + anAccount.Document_number__c;
            Account oldAccount = oldAccountsByDocAndType.get(key);

            if (oldAccount != null && oldAccount.Id != anAccount.Id) {
                anAccount.addError('An account already exists with the same document type and number');
            }
        }
    }
}