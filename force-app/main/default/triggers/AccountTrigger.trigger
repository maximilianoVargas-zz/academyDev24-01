trigger AccountTrigger on Account (before insert, before update) {
    if(Trigger.isBefore) {
        if(Trigger.isInsert) {
            AccountValidation.validateAccount(Trigger.new);
        } else if(Trigger.isUpdate){ 
            AccountValidation.validateAccount(Trigger.new);
        }
    }
}