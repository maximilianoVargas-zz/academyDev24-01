trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
	List<Task> tasks = new List<Task>();
    for(Opportunity opp : Trigger.new){
        if(opp.StageName == 'Closed Won'){
            tasks.add(new Task(Subject = 'Follow Up Test Task',
                          	   WhatId = opp.Id));
        }
        
    }
    insert tasks;
}