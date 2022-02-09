public with sharing class AccountValidation {
    
    public static void validateAccount(List<Account> accountsToCreateOrChange) {
        List<String> identificationTypes = new List<String>();
        List<String> documentNumbers = new List<String>();

        // Document_Number__c  -->  Identification_Type__c  -->  index
        Map<String, Map<String, Integer>> accountIndexByIdentificationTypeAndDocumentNumber = 
            new Map<String, Map<String, Integer>>();

        for(Integer i = 0; i < accountsToCreateOrChange.size(); i++) {
            identificationTypes.add(accountsToCreateOrChange.get(i).Identification_Type__c);
            documentNumbers.add(accountsToCreateOrChange.get(i).Document_Number__c);

            Map<String,Integer> accountIndexByIdentificationType = new Map<String,Integer>();
            accountIndexByIdentificationType.put(
                accountsToCreateOrChange.get(i).Identification_Type__c, 
                i
            );
            accountIndexByIdentificationTypeAndDocumentNumber.put(
                accountsToCreateOrChange.get(i).Document_Number__c, 
                accountIndexByIdentificationType
            );
        }
        
        // Check if there are accounts that already have the same Identification Type AND DocumentNumber
        List<Account> accounts = [
            SELECT Id, Name, Identification_Type__c, Document_Number__c
            FROM Account
            WHERE Identification_Type__c IN :identificationTypes 
                AND Document_Number__c IN :documentNumbers
                AND Id NOT IN :accountsToCreateOrChange
        ];

        if(accounts.isEmpty()){ 
            // The accounts have an unique Identification Type and Document Number
        } else {
            // Some accounts have an Identification Type and Document Number that already exist in the database
            for (Account anAccount : accounts) {
                Integer indexOfErrorAccount = accountIndexByIdentificationTypeAndDocumentNumber
                    .get(anAccount.Document_Number__c)
                    .get(anAccount.Identification_Type__c);
                accountsToCreateOrChange.get(indexOfErrorAccount).addError(
                    'Could not insert/update the account because there ' +
                    'already exist accounts that have an Identification Type and Document Number'
                );
            }
            
        }
    }
    
}