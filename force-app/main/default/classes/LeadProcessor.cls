public class LeadProcessor implements Database.Batchable<sObject> {
    public Database.QueryLocator start(Database.BatchableContext dbc){
        return Database.getQueryLocator([SELECT Id FROM Lead]);
    }
    
    public void execute(Database.BatchableContext dbc, List<Lead> leads){
        for (Lead l : leads) {
            l.LeadSource = 'DreamForce';
        }
        update leads;
    }
    
    public void finish(Database.BatchableContext dbc){
        
    }
}