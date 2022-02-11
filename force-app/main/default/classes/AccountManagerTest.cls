@isTest
private class AccountManagerTest {
    @isTest
    private static void testGetAccount(){
        Id recordId = createTestRecord();
        RestRequest request = new RestRequest();
        request.requestUri = 'https://yourInstance.salesforce.com/services/apexrest/Accounts/'+recordId+'/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        Account thisAccount = AccountManager.getAccount();
        System.assert(thisAccount != null);
        System.assertEquals('Test record', thisAccount.Name);
    }
    @isTest
    static Id createTestRecord(){
         Account TestAcc = new Account(
          Name='Test record');
        insert TestAcc;
        Contact TestCon= new Contact(
        LastName='Test', 
        AccountId = TestAcc.id);
        return TestAcc.Id;
    }
}