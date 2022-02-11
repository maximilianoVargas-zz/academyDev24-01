@IsTest
private class AccountWebServiceTest {
    @isTest 
    static void testGetAccountById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Accounts/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Test.startTest();
        Account thisAccount = AccountWebService.getAccountById();
        Test.stopTest();
        // Verify results
        System.assertNotEquals(thisAccount, null, 'Did not get an account with the requested Id');
        System.assertEquals('Springfield Power Plant', thisAccount.Name, 'The names do not match');
    }
    // Helper method
    static Id createTestRecord() {
        // Create test records
        Account accountTest = new Account(
            Name='Springfield Power Plant'
            );
        insert accountTest;

        List<Contact> testContacts = new List<Contact>();
        Contact contactTest1 = new Contact(
            FirstName = 'Homer',
            LastName = 'Simpson',
            AccountId = accountTest.Id,
            Principal_Contact__c = true
        );
        testContacts.add(contactTest1);
        Contact contactTest2 = new Contact(
            FirstName = 'Marge',
            LastName = 'Simpson',
            AccountId = accountTest.Id
        );
        testContacts.add(contactTest2);
        insert testContacts;

        List<Opportunity> testOpportunities = new List<Opportunity>();
        Opportunity oppTest1 = new Opportunity(
            Name = 'Plutonium 1',
            CloseDate = Date.today(),
            AccountId = accountTest.Id,
            StageName = 'Prospecting'
        );
        testOpportunities.add(oppTest1);
        Opportunity oppTest2 = new Opportunity(
            Name = 'Plutonium 2 the last chance',
            CloseDate = Date.today(),
            AccountId = accountTest.Id,
            StageName = 'Prospecting'
        );
        testOpportunities.add(oppTest2);
        insert testOpportunities;


        return accountTest.Id;
    }          
}
