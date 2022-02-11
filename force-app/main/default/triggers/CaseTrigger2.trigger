trigger CaseTrigger2 on Case (after Update) {
    if (Trigger.isAfter) {
        if (Trigger.isUpdate) {
            CaseTriggerHandler2.UpdatePrincipalCase(Trigger.new);
        }
    }
}