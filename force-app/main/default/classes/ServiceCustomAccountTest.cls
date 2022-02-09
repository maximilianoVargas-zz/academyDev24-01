@isTest
public with sharing class ServiceCustomAccountTest {

    @TestSetup
    static void makeData(){
        Account anAccount = new Account(
            Name = 'Cuenta 1'
        );
        insert anAccount;

        Contact aContact = new Contact(
            LastName = 'Julian',
            AccountId = anAccount.Id
        );
        insert aContact;

        Opportunity anOpportunity = new Opportunity(
            Name = 'Opportunity 1',
            StageName = 'Closed Won',
            CloseDate = Date.today(),
            AccountId = anAccount.Id
        );
        insert anOpportunity;
    }

    @isTest static void testGetCaseById() {

        Account anAccount = [SELECT Id FROM Account Where Name = 'Cuenta 1'];

        RestRequest request = new RestRequest();
        request.requestUri =
            'https://instance.salesforce.com/services/apexrest/CustomAccount/getAccountData/'
            + anAccount.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;

        AccountData accountData = ServiceCustomAccount.getAccountData();
        
        System.assert(accountData != null);
        System.assert(accountData.account != null);
        System.assertEquals('Cuenta 1', accountData.account.Name);

        System.assert(accountData.lastOpportunity != null);
        System.assertEquals('Opportunity 1', accountData.lastOpportunity.Name);

        System.assert(accountData.principalContact != null);
        System.assertEquals('Julian', accountData.principalContact.Name);

    }

}
