trigger AccountTrigger on Account (after insert, after update) {
    if (Trigger.isAfter){
        
        if(Trigger.isInsert){
             AccountValidation.validateAccount(Trigger.new);
            }
           
        } else if (Trigger.isUpdate) {
            AccountValidation.validateAccount(Trigger.new);
        }
}
