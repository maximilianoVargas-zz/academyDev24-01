/**Name = "Opportunity" + account name + current date
Stage = "Prospection”
ClosedDate = current date + 30 days */

public with sharing class AccountManage {
    public static void createOpportunity(List<Account> accounts) {

        List<Opportunity> opportsToCreate = new List<Opportunity>();
        for(Account anAccount:accounts){
            if(anAccount.Opportunity__c==true){
                Opportunity newOpport = new Opportunity(
                    AccountId = anAccount.Id,
                    Name = 'Opportunity'+anAccount.Name+System.now().date(),
                    CloseDate = System.now().date() + 30
                );
                opportsToCreate.add(newOpport);
            }
        }
        insert opportsToCreate;    

    }
}
