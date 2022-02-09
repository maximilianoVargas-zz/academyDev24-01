trigger CaseTrigger on Case (after update) {
    if(Trigger.isUpdate){
        if(Trigger.isAfter){
            List<Case> cases = new List<Case>();
            for(Integer i = 0; i<Trigger.new.size(); i++){
                if(Trigger.old.get(i).Result__c != null && Trigger.old.get(i).Result__c != Trigger.new.get(i).Result__c){
                    cases.add(Trigger.new.get(i));
                }
            }
            CaseTriggerHandler.updateAssociatedCases(cases);
        }
    }
}