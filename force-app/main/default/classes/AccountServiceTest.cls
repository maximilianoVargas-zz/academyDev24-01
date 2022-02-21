@IsTest
private class AccountServiceTest {
    @isTest static void testGetAccountByIdandRelatedPrincipalContact() {
        Id recordId = createTestRecord();

        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Account/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;

        Account thisAccount = AccountService.getAccountById();

        System.assert(thisAccount != null);
        System.assertEquals('TestContactFirstName', thisAccount.Principal_Contact__r.FirstName);
    }
    
    static Id createTestRecord() {
        Opportunity anOpportunity = new Opportunity(
            Name = 'TestOpportunity',
            StageName = 'Prospecting',
            CloseDate = Date.today(),
            Amount = 100.000
        );
        insert anOpportunity;
        Contact aContact = new Contact(
            FirstName = 'TestContactFirstName',
            LastName = 'TestContactLastName'
        );
        insert aContact;
        Account anAccount = new Account(
            Name='TestAccountName',
            Principal_Contact__c = aContact.Id
        );
        insert anAccount;

        return anAccount.Id;
    }          
}