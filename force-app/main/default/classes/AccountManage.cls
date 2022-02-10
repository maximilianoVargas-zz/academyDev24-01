public with sharing class AccountManage {

    public static void createOpportunity(List<Account> accounts){
        List<Opportunity> newOpportunities = new List<Opportunity>();
        for(Account anAccount : accounts){
            if(anAccount.create_opportunity__c){
                Opportunity newOpportunity = new Opportunity(
                    Name = 'Opportunity' + anAccount.Name + System.today().format(),
                    StageName = 'Prospection',
                    CloseDate = System.today().addDays(30),
                    AccountId = anAccount.Id
                );
                newOpportunities.add(newOpportunity);
            }
        }
        insert newOpportunities;

    }
}