trigger AccountTrigger on Account (after insert, after update) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            AccountValidation.validateAccount(Trigger.new);
        } else if(Trigger.isUpdate){ 
            List<Account> accountsToUpdate = new List<Account>();
            for (Id newAccountId : Trigger.newMap.keySet()) {
                Account oldAccount = Trigger.oldMap.get(newAccountId);
                Account newAccount = Trigger.newMap.get(newAccountId);
                if(oldAccount.Identification_Type__c != newAccount.Identification_Type__c
                    || oldAccount.Document_Number__c != newAccount.Document_Number__c)
                {
                    // Some of those 2 fields changed. The trigger must act over this account
                    accountsToUpdate.add(newAccount);
                }
            }
            AccountValidation.validateAccount(accountsToUpdate);
        }
    }
}