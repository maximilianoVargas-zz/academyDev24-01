@IsTest
public with sharing class AccountManageTest {
 

    @IsTest
    public static void whenCreateOpportunityWhenCreaterOpportunityFieldIsTrue(){

        List<Account> accounts = new List<Account>();
        for(Integer i = 0;  i<20 ; i++){
            accounts.add(
                new Account(
                    Name = 'test ' +i,
                    create_opportunity__c = true
                )
            );
        }

        Test.startTest();
        AccountManage.createOpportunity(accounts);
        Test.stopTest();

        List<Opportunity> opportunities = [
            SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :accounts
        ];

        System.assertEquals(20, opportunities.size(), 
        'La cantidad de oportunidades creadas no es igual a la cantidad de cuentas con el campo create_oportunity en True');

    }

}