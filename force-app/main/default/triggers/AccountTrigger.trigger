trigger AccountTrigger on Account (before insert, before update) {
    AccountValidation.validateAccount(Trigger.new);
    }