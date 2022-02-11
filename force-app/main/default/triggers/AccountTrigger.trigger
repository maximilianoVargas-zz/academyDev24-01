trigger AccountTrigger on Account (before insert, after insert) {
    if (Trigger.isBefore) {
        if (Trigger.isInsert) {
            AccountValidation.validateAccount(Trigger.new);
        }
    }else if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            AccountManage.createOpportunity(Trigger.new);
        }
    }

}