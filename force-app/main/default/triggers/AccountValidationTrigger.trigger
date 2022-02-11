trigger AccountValidationTrigger on Account (before insert, after update) {
    if (Trigger.isBefore){
        if (Trigger.isInsert){
            AccountValidation.validateAccount(Trigger.new);
        }
    }
    if (Trigger.isAfter){
        if (Trigger.isUpdate){
            List<Account> accountsThatChangedDocument = new List<Account>();
            for (Account anAccount : Trigger.new){
                Account oldAccount = Trigger.oldMap.get(anAccount.Id);
                if (anAccount.Document_Number__c != oldAccount.Document_Number__c 
                    || anAccount.Identification_Type__c != oldAccount.Identification_Type__c){

                    accountsThatChangedDocument.add(anAccount);
                }
            }
            AccountValidation.validateAccount(accountsThatChangedDocument);
        }
    }
}