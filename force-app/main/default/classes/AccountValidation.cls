public with sharing class AccountValidation {
    
    public static void validateAccount(List<Account> accountsToCreateOrChange) {
        List<String> identificationTypes = new List<String>();
        List<String> documentNumbers = new List<String>();

        for(Account anAccount : accountsToCreateOrChange) {
            identificationTypes.add(anAccount.Identification_Type__c);
            documentNumbers.add(anAccount.Document_Number__c);
        }
        
        List<Account> accounts = [
            SELECT Id
            FROM Account
            WHERE Identification_Type__c IN :identificationTypes 
                AND Document_Number__c IN :documentNumbers
                AND Id NOT IN :accountsToCreateOrChange
        ];

        if(accounts.isEmpty()){ 
            // The accounts have an unique Identification Type and Document Number
        } else {
            // The accounts have an Identification Type and Document Number that already exist in the database
            accountsToCreateOrChange.get(0).addError('Could not insert/update new accounts because they' +
                'have an Identification Type and Document Number that already exist in the database');
        }
    }
    
}