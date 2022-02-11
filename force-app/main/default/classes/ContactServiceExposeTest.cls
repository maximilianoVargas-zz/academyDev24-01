@isTest
public with sharing class ContactServiceExposeTest {

    @TestSetup
    static void makeData(){
        Account newAccount = new Account(
            Name = 'Globant'
        );

        insert newAccount;

        Contact newContact = new Contact(
            FirstName = 'Contacto',
            LastName = 'Prueba',
            AccountId = newAccount.Id
        );

        insert newContact;

        Opportunity newOpportunity = new Opportunity(
            AccountId = newAccount.Id,
            Name = 'Oportunidad de prueba',
            StageName = 'Prospecting',
            CloseDate = System.today()
        );

        insert newOpportunity;
    }
    
    @isTest
    public static void whenGetNamePrincicalAndLastOppurtunityMethodIsCalled(){

        Account anAccount = [
            SELECT Id 
            FROM Account
            WHERE Name = 'Globant'
        ];
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://globant370-dev-ed.lightning.force.com/services/apexrest/Cases/'
            + anAccount.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        ContactServiceExpose.CustomContactWrapper thisCase = ContactServiceExpose.getNamePrincicalAndLastOppurtunity();
        // Verify results
        System.assert(thisCase != null);
        System.assertEquals('Globant', thisCase.Name);
        System.assertEquals('Prueba', thisCase.principalContact.LastName);
        System.assertEquals('Oportunidad de prueba', thisCase.LastOpportunity.Name);

    }

}
