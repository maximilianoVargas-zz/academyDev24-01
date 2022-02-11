@isTest
public with sharing class AccountManageTest {

    @isTest
    public static void createOpportunity(){
        List<Account> accounts = new List<Account>();
        for(integer i = 0; i<9; i++){
            Account anAccount = new Account(
                Name = 'Account '+i,
                Opportunity__c = true                    
                );
            accounts.add(anAccount);
        }
        
        Test.startTest();
        insert accounts;
        Test.stopTest();

        Map<Id,Account> accountsById = new Map<Id,Account>();
        for(Account anAccount:  accounts){
            accountsById.put(anAccount.Id, anAccount);
        }

        List<Opportunity> opportunities =  [
            SELECT Name, StageName, CloseDate,AccountId
            FROM Opportunity
        ];

        System.assertEquals(9, opportunities.size(),'Las oportunidades no tienen el mismo tamaño que las cuentas');

        for(Opportunity anOpportunity : opportunities){
            Account relatedAccount = accountsById.get(anOpportunity.AccountId);
            System.assertEquals(anOpportunity.AccountId, relatedAccount.Id, 'la lista de leads no contiene el accountId relacionado');
            System.assertEquals(true, anOpportunity.Name.contains(relatedAccount.Name), 'El nombre de la oportunidad no contiene el nombre de la cuenta');
            System.assertEquals('Prospection', anOpportunity.StageName, 'El nombre dedel stage no es Prospection');
        }
    }
}