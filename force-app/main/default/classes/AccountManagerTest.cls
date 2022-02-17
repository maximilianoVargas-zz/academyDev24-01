@isTest
private class AccountManagerTest {
    
    @isTest
    static void testGetAccount() {
        Id recordId = createAccountWithContact();
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://globant-3b8-dev-ed.lightning.force.com/services/apexrest//Accounts/'+ recordId+'/contacts';
            request.httpMethod = 'GET';
            RestContext.request = request;
            Account thisAccount = AccountManager.getAccount();
            System.assert(thisAccount != null);
            System.assertEquals('Test Account', thisAccount.Name);
    }
    
    private static Id createAccountWithContact(){
        Account acc = new Account(Name = 'Test Account');
        insert acc;
        Contact con1 = new Contact(firstname = 'con1', lastname = 'con1last', accountId = acc.Id );
        insert con1;
        Contact con2 = new Contact(firstname = 'con2', lastname = 'con2last', accountId = acc.Id );
        insert con2;
        return acc.Id;
    }

}