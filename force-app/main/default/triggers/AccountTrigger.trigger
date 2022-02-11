trigger AccountTrigger on Account (before insert, before update, after update) {
    if(Trigger.isBefore){
        if(Trigger.isUpdate){
            for(String oldAccountId:Trigger.oldMap.keySet()){
                if(Trigger.newMap.get(oldAccountId).Document_number__c!=
                    Trigger.oldMap.get(oldAccountId).Document_number__c||
                    Trigger.oldMap.get(oldAccountId).Identification_type__c!=
                    Trigger.newMap.get(oldAccountId).Identification_type__c){
                        
                    AccountValidation.validateAccount(Trigger.new);
                }    
            }
        }
        if(Trigger.isInsert){
            AccountValidation.validateAccount(Trigger.new);
        }
    } else if(Trigger.isAfter){
        if(Trigger.isUpdate){
            AccountManage.createOpportunity(Trigger.new);
        }

    }
    
}