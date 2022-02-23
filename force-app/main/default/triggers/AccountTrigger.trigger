trigger AccountTrigger on Account (before insert, before update, after insert) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            List<Account> accounts = new List<Account>();

            for(Account anAccount : Trigger.new){
                if(anAccount.Identification_type__c != null && anAccount.Document_number__c != null){
                    accounts.add(anAccount);
                }
            }
            AccountTriggerHandler.validateAccount(accounts);
        }
        else if(Trigger.isUpdate){
            List<Account> accounts = new List<Account>();

            for(Account anAccount : Trigger.new){
                if(anAccount.Token__c != Trigger.oldMap.get(anAccount.Id).Token__C){
                    accounts.add(anAccount);
                }
            }
            AccountTriggerHandler.validateAccount(accounts);
        }
    }

    if(Trigger.isAfter){
        if(Trigger.isInsert){
            AccountManage.createOpportunity(Trigger.new);
        }
    }
}