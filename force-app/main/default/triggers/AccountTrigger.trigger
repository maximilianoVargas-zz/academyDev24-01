trigger AccountTrigger on Account (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountValidation.validateAccount(trigger.new, false);
        } else if (Trigger.isUpdate){
            AccountValidation.validateAccount(trigger.new, true);
        }
    }
}