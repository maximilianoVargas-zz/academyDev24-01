@IsTest 
private class AccountServiceTest {   
    
    @testSetup
    static void makeData() {    
        // Create an account     
        Account accountTest = new Account(             
            Name='Test record'
        );           
        insert accountTest;

        // Associate a contact to the created account
        Contact contactTest= new Contact(         
            FirstName='John',         
            LastName='Doe',         
            AccountId=accountTest.Id
        );         
        insert contactTest;

        // Associate an opportunity to the created account
        Opportunity opp = new Opportunity(
            name = 'opp name',
            StageName = 'stage name',
            CloseDate = date.today(),
            AccountId = accountTest.Id
        );
        insert opp;
    } 
    
    @isTest
    static void whenMakeHttpGetToAccountsWithIdThenReturnTheAccountWithThatId() {         
        Account acc = [
            SELECT Id, Name
            FROM Account
            WHERE Name = 'Test record'
        ];
                
        RestRequest request = new RestRequest();
        request.requestUri = 'https://myinstance.salesforce.com/services/apexrest/Accounts/' + acc.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;

        Test.startTest();
        Account thisAccount = AccountService.getAccount();
        Test.stopTest();

        System.assert(thisAccount != null, 'The account cant be null');
        System.assertEquals(acc.Name, thisAccount.Name, 'The account retrieved must be the same as the variable "acc"');
    }

    @IsTest
    static void whenMakeHttpGetToNonexistenAccountThenNullIsReturned(){
        String nonExistantAccountId = 'nonexistant';
                
        RestRequest request = new RestRequest();
        request.requestUri = 'https://myinstance.salesforce.com/services/apexrest/Accounts/' + nonExistantAccountId;
        request.httpMethod = 'GET';
        RestContext.request = request;

        Test.startTest();
        Account thisAccount = AccountService.getAccount();
        Test.stopTest();

        System.assertEquals(null, thisAccount, 'The account must be null');
    }
              
}
