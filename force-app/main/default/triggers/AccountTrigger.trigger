trigger AccountTrigger on Account (before insert,before update) {

    if(Trigger.isBefore){
        if(Trigger.isInsert){  
            AccountManage.validateAccount(Trigger.new); 
            AccountManage.createOpportunity(Trigger.new);
        }
        else if(Trigger.isUpdate){
            AccountManage.validateAccount(Trigger.new); 
        }
    }  
}