@isTest
public with sharing class AccountApiServiceTest {
    @TestSetup
    static void makeData(){
        List<Contact> contacts = new List<Contact>();
        List<Opportunity> opportunities = new List<Opportunity>();
        Account anAccount = new Account(Name='Test Account');
        insert anAccount;

        Contact aContact = new Contact(FirstName='Main',
                                        LastName='Contact',
                                        Main_Contact__c=true,
                                         AccountId=anAccount.Id);
        Contact secondaryContact = new Contact(FirstName='Secondary',
                                         LastName='Contact',
                                         Main_Contact__c=false,
                                          AccountId=anAccount.Id);

        contacts.add(aContact);
        contacts.add(secondaryContact);
        insert contacts;

        Opportunity eldestOpportunity = new Opportunity(AccountId=anAccount.Id, 
                                                    Name='Earliest Opportunity', 
                                                    StageName='Prospecting', 
                                                    CloseDate=Date.today().addDays(7));
        Opportunity anOpportunity = new Opportunity(AccountId=anAccount.Id, 
                                                    Name='Latest Opportunity', 
                                                    StageName='Prospecting', 
                                                    CloseDate=Date.today().addDays(10));
        opportunities.add(anOpportunity);
        opportunities.add(eldestOpportunity);
        insert opportunities;
    }
    
    @isTest static void shouldBringPrincipalContactAndLatestOpportunityWithAccount(){
        Id requestId = [
            SELECT Id
            FROM Account
            WHERE Name LIKE 'Test Account'
        ].Id;
        RestRequest request = new RestRequest();
        request.requestURI = 'https://mindful-goat-vwsyqb-dev-ed.my.salesforce.com/services/apexrest/SpecialQuery/Account/' +
                            requestId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        Account response = AccountApiService.getAccountById();

        System.assertEquals('Main Contact', response.Contacts[0].Name, 'Not main contact');
        System.assertEquals('Latest Opportunity', response.Opportunities[0].Name, 'Not latest opportunity');
    }
    
    @isTest static void shouldBringNullAccountSinceIdIsNotFound(){
        String requestId = 'abcd123456';
        RestRequest request = new RestRequest();
        request.requestURI = 'https://mindful-goat-vwsyqb-dev-ed.my.salesforce.com/services/apexrest/SpecialQuery/Account/' +
                            requestId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        Account response = AccountApiService.getAccountById();

        System.assertEquals(null, response, 'Found something other than null');
    }
}
