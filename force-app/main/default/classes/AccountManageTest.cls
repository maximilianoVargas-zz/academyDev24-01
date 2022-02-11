@isTest
public with sharing class AccountManageTest {

    @isTest
    public static void whenAccountNeedToCreateAnOpportunity() {
        List<Account> accounts = new List<Account>();
        for(Integer i = 0; i < 10; i++) {
            accounts.add(
                new Account(
                    Name = 'test' + i,
                    Create_Opportunity__c = true
                )
            );
        }

        Test.startTest();
        insert accounts;
        AccountManage.createOpportunity(accounts);
        Test.stopTest();
        Map<Id, Account> accountsById = new Map<Id, Account>();
        for(Account anAccount : accounts) {
            accountsById.put(anAccount.Id, anAccount);
        }

        List<Opportunity> opportunities = [SELECT Id, AccountId FROM Opportunity];

        System.assertEquals(10, opportunities.size(), 'Las oportunidades no tienen el mismo tamaño que las accounts');

        for(Opportunity op : opportunities) {
            Account ac = accountsById.get(op.AccountId);
            System.assertEquals(op.AccountId, ac.Id, 'La oportunidad no esta relacionada con la cuenta');
        }

    }
    
}