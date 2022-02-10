trigger AccountValidationTrigger on Account (before insert,before update) {
    if(Trigger.isBefore){
        if (Trigger.isInsert || Trigger.isUpdate) {
            AccountValidation.validateAccount(Trigger.new);
        }
    }
}