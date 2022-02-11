public with sharing class AccountManage {
    public static void createOpportunity(List<Account> accounts){
        List<Opportunity> opportunities = new List<Opportunity>();
        for(Account anAccount: accounts){
            if(anAccount.Opportunity__c){
                Opportunity anOpportunity = new Opportunity();
                anOpportunity.AccountId = anAccount.Id;
                anOpportunity.Name = 'Opportunity' + anAccount.Name + Date.today().format();
                anOpportunity.StageName = 'Prospection';
                anOpportunity.CloseDate = Date.today().addDays(30);
                opportunities.add(anOpportunity);
            }
        }

        insert opportunities;
    }
}