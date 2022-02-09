trigger AccountTrigger on Account (before insert, before update) {
    List<Account> accounts = trigger.new;
    for(Account anAccount : accounts){
        AccountValidation.validateAccount(anAccount);        
    }
}