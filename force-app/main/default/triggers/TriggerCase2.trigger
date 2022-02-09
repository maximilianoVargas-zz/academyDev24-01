trigger TriggerCase2 on Case (after update) {
    if(Trigger.isAfter){
        if (Trigger.isUpdate) {
            List<Case> cases=Trigger.new;
            for (Case aCase : cases) {
                if (aCase.ParentId!=null) {
                    TriggerExercise2.dosomething(cases);
                }
            }
        }
    }
}