trigger TriggerCase1 on Case (after insert) {
    if(Trigger.isAfter){
        if (Trigger.isInsert) {
            TriggerExercise1.relatedTask(Trigger.new);
        }
    }
}