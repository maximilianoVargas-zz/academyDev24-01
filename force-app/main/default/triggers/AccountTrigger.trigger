trigger AccountTrigger on Account (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            
            if(AccountValidation.validateAccount(Trigger.new) == true){
                Trigger.new[0].addError('There is an existing account with the same Document Number');
        }
    }
}
}