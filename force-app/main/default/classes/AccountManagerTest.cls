@isTest
private class AccountManagerTest {
   @isTest
    static void testGetAccount(){
        Account a = new Account(Name ='testaccount');
        insert a;
        Contact c = new Contact(AccountId = a.Id, FirstName='Test', LastName='Test');
        insert c;
        
         RestRequest request = new RestRequest();
        request.requestUri =
            'https://sandeepidentity-dev-ed.my.salesforce.com/services/apexrest/Accounts/'
            + a.Id +'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        Account myAccount = AccountManager.getAccount();
        System.assert(myAccount!= null);
        System.assertEquals('testaccount', myAccount.Name);
    }
    
}