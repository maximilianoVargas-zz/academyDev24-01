trigger CaseTrigger on Case (after insert,after update) {
    if(Trigger.isAfter){
        if (Trigger.isInsert) {
            Case1TriggerHandler.relatedTask(Trigger.new);
        }
        if (Trigger.isUpdate) {
            List<Case> cases=Trigger.new;
            for (Case aCase : cases) {
                if (aCase.ParentId!=null) {
                    Case1TriggerHandler.updatedRelatedParentCase(cases);
                }
            }
        }
    }
}