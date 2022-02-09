public with sharing class AccountManage2 {
   public static void createOpportunity(List<Account> ListAccount){

        List<Opportunity> ListOpportunities=new List<Opportunity>();

        for(Account anAccount : ListAccount){
            if(anAccount.create_opportunity__c==true){
                Opportunity anOpportunity=new Opportunity();
                anOpportunity.Name='Opportunity ' + anAccount.Name +' '+Date.TODAY();
                anOpportunity.StageName='Prospection';
                anOpportunity.CloseDate=Date.TODAY()+30;
                ListOpportunities.add(anOpportunity);
            }
        }

        insert ListOpportunities;
   }
}