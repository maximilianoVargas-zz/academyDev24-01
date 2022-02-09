trigger TriggerCase2 on Case (after update) {
    TriggerExercise2.dosomething(Trigger.new);
}