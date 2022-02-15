public class VisualforcePageExerciseController {
	
    public List<Account> accounts {get;set;}
    
	public VisualforcePageExerciseController() {
        accounts = [
            SELECT Id, Name, Description, MessageBody__c
            FROM Account
            LIMIT 200
        ];
        
	}
    public void saveMessage(){
        List<Message__c> messages = new List<Message__c>();
        for(Account anAccount : accounts){
            if(anAccount.MessageBody__c != '' && anAccount.MessageBody__c != null){
             	Message__c aMessage = new Message__c();
            	aMessage.Account__c = anAccount.Id;
            	aMessage.Description__c = anAccount.MessageBody__c;
				messages.add(aMessage);  
            }
        }
        insert messages;
    }
}