@IsTest
public with sharing class AccountManagerTest {
    @IsTest static void testGetCaseById() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://empathetic-wolf-ebt6x9-dev-ed.my.salesforce.com/services/apexrest/AccountsCustom/'+ recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        AccountManager.ResponseWrapper response = AccountManager.getAccountDetails();
        
        System.assert(response != null,'The account was not found');
        System.assertEquals('New Account', response.anAccount.Name,'The account does not match');
        System.assertEquals('Primary', response.aContact.Firstname,'The principal contact does not match');
        System.assertEquals('Last', response.anOportunuty.Name,'The last Opportunity does not match');
    }
    
    static Id createTestRecord() {
        Account accountTest = new Account(
            Name = 'New Account'
            );
        insert accountTest;

        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(firstname = 'Primary', lastname = 'Contact', accountId = accountTest.Id, Principal__c = true ));
        contacts.add(new Contact(firstname = 'NonPrimary', lastname = 'Contact', accountId = accountTest.Id, Principal__c = false ));
        insert contacts;

        List<Opportunity> opportunities = new List<Opportunity>();
        Date closeDate = Date.today().addDays(1);
        opportunities.add(new Opportunity(Name='Last',StageName='Last',CloseDate=closeDate, accountId= accountTest.Id));
        insert opportunities;

        return accountTest.Id;
    }      
}