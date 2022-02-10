trigger AccountTrigger on Account (before insert) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){
            AccountValidation.validateAccount(Trigger.new);                        
        }
    }
}