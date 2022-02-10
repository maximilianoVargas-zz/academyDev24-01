@isTest
public with sharing class AccountApiTest {
    @isTest
    static void shouldReturnAccountByAnAccountId(){
        Id accountId=createTestRecord();
        RestRequest request = new RestRequest();
        request.requestURI='mindful-hawk-1qej8q-dev-ed.my.salesforce.com/services/apexrest/Accountjd/' + accountId;
        request.httpMethod='GET';

        RestContext.request=request;

        Account account=AccountApi.getAccountById();

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

    static Id createTestRecord(){
        Account account = new Account(Name='examplename');
        insert account;

        Opportunity opp1=new Opportunity();
        opp1.AccountId=account.Id;
        opp1.Name='oppname1';
        opp1.StageName='stagename1';
        opp1.CloseDate=Date.newInstance(2022, 03, 03);
        opp1.Description='desc1';

        Opportunity opp2=new Opportunity();
        opp2.AccountId=account.Id;
        opp2.Name='oppname2';
        opp2.StageName='stagename2';
        opp2.CloseDate=Date.newInstance(2022, 03, 03);
        opp2.Description='desc2';

        Contact contact1=new Contact();
        contact1.AccountId=account.Id;
        contact1.Level__c='Primary';
        contact1.FirstName='name1';
        contact1.LastName='lastname1';

        Contact contact2=new Contact();
        contact2.AccountId=account.Id;
        contact2.Level__c='Secondary';
        contact2.FirstName='name2';
        contact2.LastName='lastname2';

        insert contact1;
        insert contact2;

        insert opp1;
        insert opp2;

        Datetime aDate = Datetime.now().addMinutes(10);
        Test.setCreatedDate(opp2.Id, aDate);

        return account.Id;
    }
}