trigger AccountTrigger on Account (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountTriggerHandler.AccountTriggerValidateAccount(Trigger.New);    
        }else if(Trigger.isUpdate){
            AccountTriggerHandler.AccountTriggerValidateAccount(Trigger.New);     
        }
    }
}