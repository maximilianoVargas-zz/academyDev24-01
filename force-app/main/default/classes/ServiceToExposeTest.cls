@isTest
public with sharing class ServiceToExposeTest {
    @TestSetup
    static void makeData(){
        Account anAccount = new Account();
        anAccount.Name = 'Test Account For Service';

        insert anAccount;

        Contact aContact = new Contact();
        aContact.LastName = 'Madona';
        aContact.AccountId = anAccount.Id;
        aContact.Main_Contact__c = true;

        insert aContact;

        Opportunity anOpportunity = new Opportunity();
        anOpportunity.Name = 'Test Opportunity';
        anOpportunity.AccountId = anAccount.Id;
        anOpportunity.StageName = 'Porspecting';
        anOpportunity.CloseDate = Date.today();

        insert anOpportunity;
    }
    @isTest
    static void getAccountPrincipalContactAndLastOppCreatedTest() {

        Account anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'Test Account For Service'
            LIMIT 1
        ];

        RestRequest request = new RestRequest();
        request.requestUri = 'https://curious-bear-7p5nuv-dev-ed/services/apexrest/Account/' + anAccount.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;

        Test.startTest();
        ServiceToExpose.customWrapper wrapper = ServiceToExpose.getAccountPrincipalContactAndLastOppCreated();
        Test.stopTest();
        
        System.assertEquals('Test Account For Service', wrapper.anAccount.Name);
        System.assertEquals('Madona', wrapper.aContact.LastName);
        System.assertEquals('Test Opportunity', wrapper.anOpportunity.Name);

    }
}
