@isTest
public with sharing class ExposingApiRestTest {
    @isTest static void testGetAccountByIdAndSendMainContact() {
        Account newAccount = new Account(
            Name = 'ExposedName'
            
        );
        insert newAccount;
        Contact newContact = new Contact(
            LastName = 'First Contact',
            AccountId = newAccount.Id
        );
        insert newContact;
        
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Account/'
            + newAccount.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Contact aContact = ExposingApiRestService.getAccountById();
        // Verify results
        System.assertEquals('First Contact', aContact.LastName, 'No muestra LastName de Contact');
    }
}
