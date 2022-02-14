trigger CaseTrigger on Case (after insert,after Update) {
    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            CaseTriggerHandler.realatedTask(Trigger.new);
        }
        else if (Trigger.isUpdate) {
            CaseTriggerHandler.UpdatePrincipalCase(Trigger.new);
        }
    }
}