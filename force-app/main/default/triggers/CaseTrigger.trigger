trigger CaseTrigger on Case (after update) {
    if(Trigger.isAfter){
        if(Trigger.isUpdate){

            Map<String, Case> casesByParentId = new Map<String, Case>();

            for (Case aCase : Trigger.new) {
                casesByParentId.put(aCase.ParentId, aCase);
            }
            List<Case> allCases = [SELECT Id,ParentId, Result__c
                                FROM Case
                                WHERE Id 
                                IN :casesByParentId.keySet()];

            //Manera 1:

            // List<Case> changedCases = new List<Case>();
            // for(Case cp : allCases){
            //     for(Case cc : Trigger.new){
            //         if(cc.ParentId == cp.Id){
            //             cp.Result__c = cc.Result__c;
            //             changedCases.add(cp);
            //         }
            //     }
            // update changedCases;
            // } 
            
            //Manera 2:

            List<Case> updatedCases = new List<Case>();
            for (Case aCase : allCases) {
                if(casesByParentId.containsKey(aCase.Id)){
                    aCase.Result__c = casesByParentId.get(aCase.Id).Result__c;
                    updatedCases.add(aCase);
                }
            }

            update updatedCases;
        }
    }
}