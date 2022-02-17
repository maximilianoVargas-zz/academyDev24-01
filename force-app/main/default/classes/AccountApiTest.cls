@isTest
public with sharing class AccountApiTest {

    @TestSetup
    static void makeData(){
        Account account = new Account(Name='examplename');
        insert account;

        Opportunity opportunity2=new Opportunity(AccountId=account.Id,Name='oppname2',StageName='stagename2',CloseDate=Date.newInstance(2022, 03, 03),Description='desc2');
        List<Opportunity> opportunities=new List<Opportunity>{
            new Opportunity(AccountId=account.Id,Name='oppname1',StageName='stagename1',CloseDate=Date.newInstance(2022, 03, 03),Description='desc1'), opportunity2
        };

        List<Contact> contacts=new List<Contact>{
            new Contact(AccountId=account.Id, Level__c='Primary',FirstName='name1',LastName='lastname1'),
            new Contact(AccountId=account.Id, Level__c='Secondary',FirstName='name2',LastName='lastname2')
        };


        insert contacts;
        insert opportunities;


        Datetime aDate = Datetime.now().addMinutes(10);
        Test.setCreatedDate(opportunity2.Id, aDate);

    }

    @isTest
    static void shouldReturnAccountByAnAccountId(){

        Account testAccount=[
            SELECT Id,Name
            FROM Account
            WHERE Name='examplename'
        ][0];

        Id accountId = testAccount.Id;

        RestRequest request = new RestRequest();
        request.requestURI='mindful-hawk-1qej8q-dev-ed.my.salesforce.com/services/apexrest/Accountjd/' + accountId;
        request.httpMethod='GET';

        RestContext.request=request;

        Test.startTest();
        Account account=AccountApi.getAccountById();
        Test.stopTest();

        System.assert(account!=null);
        //validate name account
        System.assertEquals('examplename', account.Name,'accout name does not match with expected');

        //validate principal contact
        Contact con=account.Contacts[0];
        System.assertEquals('name1', con.FirstName,'contact name does not match with expected');

        //validate date last created
        Opportunity opp=account.Opportunities[0];
        System.assertEquals('desc2',opp.Description,'thid not the last created date for an opportunity');
        
    }

}