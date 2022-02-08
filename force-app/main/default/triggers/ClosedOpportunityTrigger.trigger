trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
    List<Task> tareas = new List<Task>();
    for(Opportunity op : trigger.new){
        if(op.IsWon) tareas.add(
            new Task(
                Subject = 'Tarea de prueba de seguimiento',
                WhatId = op.Id
            )
        );
    }
    if(!tareas.isEmpty()) insert tareas;
}