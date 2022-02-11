trigger AccountTrigger on Account (before insert, before update) {
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            List<Account> accounts = trigger.new;
            for(Account anAccount : accounts){
                AccountValidation.validateAccount(anAccount, false);
            }
        } else if (Trigger.isUpdate){
            List<Account> accounts = trigger.new;
            for(Account anAccount : accounts){
                AccountValidation.validateAccount(anAccount, true);
            }
        }
    }
}