trigger AccountTrigger on Account (before insert,before update) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){            
            string res=AccountValidation.validateAccount(Trigger.new); 
            AccountManage2.createOpportunity(Trigger.new);
        }
        else if(Trigger.isUpdate){
           string res=AccountValidation.validateAccount(Trigger.new); 
        }
    }  
}