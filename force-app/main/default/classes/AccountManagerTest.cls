@IsTest
public class AccountManagerTest {
    @IsTest static void testGetAccountById() {
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://resourceful-hawk-kroan8-dev-ed.lightning.force.com/services/apexrest/AccountsCustom/'+ recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;

        AccountManager.WrapperResponse response = AccountManager.getAccountDetail();

        System.assert(response != null,'The account was not found');
        System.assertEquals('New Account', response.anAccount.Name,'The account name matchs');
        System.assertEquals('Principal', response.aContact.lastname,'The principal contact exists');
        System.assertEquals('Opportunity Test', response.anOpportunity.Name,'The last Opportunity '+ response.anOpportunity.Name +'matchs');
    }

    //Helper Method
    static Id createTestRecord() {
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

        return anAccountTest.Id;
    }      
}
