@isTest
public with sharing class AccountManageTest {

    @IsTest
    static void CreateNewOpportunityMethod(){
        
        List<Account> ListAccount= new List<Account>();

        Account anAccount =new Account();
        anAccount.create_opportunity__c=true;
        anAccount.Document_number__c='Test1234';
        anAccount.Identification_type__c='NIT';
        anAccount.name='Gerardo Test';

        ListAccount.add(anAccount);
        AccountManage2.createOpportunity(ListAccount);

        Opportunity anOpportinity=[SELECT Name,StageName,CloseDate 
                                  FROM Opportunity 
                                  WHERE name like 'Opportunity%'
                                  LIMIT 1];

        System.assertEquals('Opportunity Gerardo Test',anOpportinity.Name.Substring(0,24), 'The Name not match');
        System.assertEquals('Prospection',anOpportinity.StageName, 'The StageName not match');
    }
}
