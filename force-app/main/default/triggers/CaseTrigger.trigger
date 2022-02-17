trigger CaseTrigger on Case (after insert, after update) {
    if(Trigger.isAfter) {
        if(Trigger.isInsert) {
            CaseTriggerHandler.assignLatestCallToCase(Trigger.new);
        } else if(Trigger.isUpdate) {
            CaseTriggerHandler.changeAssociatedCase(Trigger.newMap, Trigger.oldMap);
        }
    }
}