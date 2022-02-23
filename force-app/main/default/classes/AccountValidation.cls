public with sharing class AccountValidation {
    public static void validateAccount(List<Account> accounts, Boolean isUpdating) {

        for (Integer i = 0; i < accounts.size(); i++) {
            for (Integer j = 0; j < i; j++) {
                if (
                    accounts.get(j).Identification_type__c == accounts.get(i).Identification_type__c &&
                    accounts.get(j).Document_number__c == accounts.get(i).Document_number__c
                ) {
                    accounts.get(i).addError('There are another account with the same ' +
                        + 'identification type and document number in the list');
                }
            }
        }


        Map<String, Account> accountsByIdentification_type = new Map<String, Account>();
        Map<String, Account> accountsByDocument_number = new Map<String, Account>();

        for (Account anAccount : accounts) {
            accountsByIdentification_type.put(anAccount.Identification_type__c, anAccount);
            accountsByDocument_number.put(anAccount.Document_number__c, anAccount);
        }
        List<Account> accountsInBase = [
            SELECT Id, Name, Identification_type__c, Document_number__c
            FROM Account
            WHERE Identification_type__c IN :accountsByIdentification_type.keySet()
            AND Document_number__c IN :accountsByDocument_number.keySet()
        ];

        if(!isUpdating){
            for (Account anAccount : accounts) {
                Integer cont = 0;
                for (Account anAccountInBase : accountsInBase) {
                    if(
                        anAccount.Identification_type__c == anAccountInBase.Identification_type__c &&
                        anAccount.Document_number__c == anAccountInBase.Document_number__c
                    ){
                        cont++;
                    }
                    if(cont>0){
                        anAccount.addError('The account already exists');
                        break;
                    }
                }
            }
        }
        
        if(isUpdating){
            for (Account anAccount : accounts) {
                Integer cont = 0;
                for (Account anAccountInBase : accountsInBase) {
                    if(
                        anAccount.Identification_type__c == anAccountInBase.Identification_type__c &&
                        anAccount.Document_number__c == anAccountInBase.Document_number__c &&
                        anAccount.Id != anAccountInBase.Id
                    ){
                        cont++;
                    }
                    if(cont>0){
                        anAccount.addError('Another account with the same document number and type already exists');
                        break;
                    }
                }
            }
        }    
    }
}