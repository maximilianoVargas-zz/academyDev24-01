@isTest
public with sharing class AccountWebServiceRestTest {

    @isTest static void GetASuccessResponseFromWebService(){

        Account anAccount =new Account();
        anAccount.Document_number__c='Test123';
        anAccount.Identification_type__c='NIT';
        anAccount.name='Gerardo Test';
        insert anAccount;

        Contact aContact=new Contact();
        aContact.FirstName='Gerardo';
        aContact.LastName='Seoane';
        aContact.AccountId=anAccount.Id;
        aContact.isPrincipal__c=true;
        insert aContact;

        Opportunity anOpportunity=new Opportunity();
        anOpportunity.Name='Opportunity Gerardo Test';
        anOpportunity.AccountId=anAccount.Id;
        anOpportunity.StageName='Prospection';
        anOpportunity.CloseDate=Date.TODAY()+30;
        insert anOpportunity;

        Test.startTest();
        string Response=AccountWebServiceRest.getAccountById(anAccount.Id);
        Test.stopTest();

        string ResponseExpected='{"Name Of Account":'+anAccount.Name+'",Principal Contac:"'+aContact.Id+'",Id Last Opportunity:"'+anOpportunity.Id+'}';

        System.assertEquals(ResponseExpected, Response,'The Response from the webService was Incorrect');
        
    }

    @isTest static void GetAFailedResponseFromWebService(){
        Account anAccount =new Account();
        anAccount.Document_number__c='Test123';
        anAccount.Identification_type__c='NIT';
        anAccount.name='Gerardo Test';
        insert anAccount;

        Test.startTest();
        string Response=AccountWebServiceRest.getAccountById(anAccount.Id);
        Test.stopTest();

        string ResponseExpected='The Id Dont have any opportunity or an account asociate';

        System.assertEquals(ResponseExpected, Response,'The response from the webService was Success');
    }
    
}
