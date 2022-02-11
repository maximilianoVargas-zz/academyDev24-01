@IsTest
public with sharing class AccountServiceTest {
    @IsTest static void getAccountWhenNotExists() {

        Account anAccount = new Account(Name='account1');
        Contact aContact = new Contact(LastName='contact1');
        Opportunity anOpportunity = new Opportunity(
            Name='opportunity1', 
            StageName='Needs Analysis', 
            CloseDate=Date.today().addMonths(6)
            );

        insert anAccount;
        insert aContact;
        insert anOpportunity;

        Account accountReturned = [
            SELECT Id
            FROM Account
            LIMIT 1
        ];

        String id = accountReturned.Id;

        delete accountReturned;

        RestRequest request = new RestRequest();
        request.requestURI = 'https://resourceful-hawk-lv2qaz-dev-ed.my.salesforce.com/services/apexrest/Accounts/v1/' + id;
        request.httpMethod = 'GET';
        RestContext.request = request;

        Test.startTest();
        String result = AccountService.getAccountWithNamePrincipalAndOpportunity();
        Test.stopTest();
        
        System.assertEquals('{"ErrorMessage" : "There are not accounts with the id: ' + id + '"}', result, 'The Account with the id param does not exists');
    }


    @IsTest static void getAccountSuccessful() {

        Account anAccount = new Account(Name='account1');
        insert anAccount;

        String nameExpected = anAccount.Name;

        Contact aContact1 = new Contact(
            LastName = 'contact1', 
            AccountId = anAccount.Id,
            Is_principal__c = true
        );
        
        Contact aContact2 = new Contact(
            LastName = 'contact2', 
            AccountId = anAccount.Id,
            Is_principal__c = false
        );

        Contact aContact3 = new Contact(
            LastName = 'contact3', 
            Is_principal__c = false
        );

        List<Contact> contacts = new List<Contact>();
        contacts.add(aContact1);
        contacts.add(aContact2);
        contacts.add(aContact3);

        insert contacts;

        String contactIdExpected = aContact1.Id;

        Opportunity anOpportunity1 = new Opportunity(
            Name='opportunity1', 
            StageName='Needs Analysis', 
            CloseDate=Date.today().addMonths(6),
            AccountId = anAccount.Id
        );

        Opportunity anOpportunity2 = new Opportunity(
            Name='opportunity2', 
            StageName='Needs Analysis', 
            CloseDate=Date.today().addMonths(6),
            AccountId = anAccount.Id
        );

        Opportunity anOpportunity3 = new Opportunity(
            Name='opportunity3', 
            StageName='Needs Analysis', 
            CloseDate=Date.today().addMonths(6)
        );

        List<Opportunity> opportunities = new List<Opportunity>();
        opportunities.add(anOpportunity1);
        opportunities.add(anOpportunity2);
        opportunities.add(anOpportunity3);

        insert opportunities;

        Test.SetCreatedDate (anOpportunity1.Id, Date.today().addDays(-2));
        Test.SetCreatedDate (anOpportunity2.Id, Date.today().addDays(-1));
        
        String OpportunityIdExpected = anOpportunity2.Id;

        Account accountReturned = [
            SELECT Id
            FROM Account
            LIMIT 1
        ];

        String id = accountReturned.Id;

        RestRequest request = new RestRequest();
        request.requestURI = 'https://resourceful-hawk-lv2qaz-dev-ed.my.salesforce.com/services/apexrest/Accounts/v1/' + id;
        request.httpMethod = 'GET';
        RestContext.request = request;

        Test.startTest();
        String result = AccountService.getAccountWithNamePrincipalAndOpportunity();
        Test.stopTest();

        String respExpected = '{' + 
        '"AccountName" : "' + nameExpected + '", ' +
        '"PrincipalContactId" : "' + contactIdExpected + '", ' +
        '"LastOpportunityId" : "' + OpportunityIdExpected + '"' +
        '}';

        System.assertEquals(respExpected, result, 'The response does not match with the response expected');
    }
}
