public with sharing class AccountValidation {

    public static Boolean validateAccount(List<Account> newAccounts){

        Map<String,String> documentNumberAndIdType = new Map<String,String>();
        for(Account account: newAccounts){
            documentNumberAndIdType.put(account.Document_number__c, 
            account.Identification_type__c);
        }

        List<Account> accounts = [SELECT id, Document_number__c,
            Identification_type__c FROM Account 
            WHERE Document_number__c IN :documentNumberAndIdType.keySet()];

        if(!accounts.isEmpty()){
            for(Account account: accounts){
                String documentType = documentNumberAndIdType.get(account.Document_number__c);
                if(documentType == account.Identification_type__c){
                    account.addError('Aviso, existe un par <Numero identificación, Tipo de documento> existente.');                    
                    return true;
                }
            }
        }        

        return false;
    }

}