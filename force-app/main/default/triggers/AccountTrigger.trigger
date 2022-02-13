trigger AccountTrigger on Account (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountTriggerHandler.AccountTriggerInsertAccount(Trigger.New);    
        }else if(Trigger.isUpdate){
            AccountTriggerHandler.AccountTriggerUpdateAccount(Trigger.New);     
        }
    }
}