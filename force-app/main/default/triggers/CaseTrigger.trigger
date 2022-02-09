trigger CaseTrigger on Case (After update) {
    if (Trigger.isAfter) {
        if (Trigger.isUpdate) {
            CaseTriggerHandler.updateParentIds(Trigger.new);
        }
    }
}