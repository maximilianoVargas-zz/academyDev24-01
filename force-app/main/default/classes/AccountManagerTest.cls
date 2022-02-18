@IsTest
public class AccountManagerTest {

    @TestSetup
    static void makeData(){

        Account anAccountTest = new Account(
            Name = 'Account Test'
            );
        insert anAccountTest;

        List<Contact> contactsTest = new List<Contact>();
        for (Integer i = 0; i < 3; i++) {
            contactsTest.add(new Contact(firstname = 'Contact Test ' +i, lastname = 'No Principal', accountId = anAccountTest.Id, Principal_Contact__c = false ));
        }
        contactsTest.add(new Contact(firstname = 'Contact Test 0', lastname = 'Principal', accountId = anAccountTest.Id, Principal_Contact__c = true ));
        insert contactsTest;

        List<Opportunity> opportunitiesTest = new List<Opportunity>();
        Date closeDate = Date.today().addDays(30);
        opportunitiesTest.add(new Opportunity(Name = 'Opportunity Test',StageName = 'Prospecting',CloseDate = closeDate, accountId = anAccountTest.Id));
        insert opportunitiesTest;

    }

    @IsTest static void testGetAccountById() {

        List<Account> anAccount = [
            SELECT Id
            FROM Account
            WHERE Name = 'Account Test'
            LIMIT 1
            ];
        Id recordId = anAccount[0].Id;
        
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://resourceful-hawk-kroan8-dev-ed.lightning.force.com/services/apexrest/AccountsCustom/'+ recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;

        Test.startTest();
        AccountManager.WrapperResponse response = AccountManager.getAccountDetail();
        Test.stopTest();

        System.assert(response != null,'The account was not found');
        System.assertEquals('Account Test', response.anAccount.Name,'The account name does not match');
        System.assertEquals('Principal', response.aContact.lastname,'The principal contact does not exist');
        System.assertEquals('Opportunity Test', response.anOpportunity.Name,'The last Opportunity '+ response.anOpportunity.Name +' does not match');
    }  
}
