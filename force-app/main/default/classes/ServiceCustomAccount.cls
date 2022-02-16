@RestResource(urlMapping='/CustomAccount/*')
global with sharing class ServiceCustomAccount {

    @HttpGet
    global static AccountData getAccountData() {

        RestRequest request = RestContext.request;
        String idAccount = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);

        Account anAccount = [
            SELECT Id, Name,
                (SELECT Id, Name 
                    FROM Contacts),
                (SELECT Id, Name
                    FROM Opportunities 
                    ORDER BY createdDate DESC) 
            FROM Account 
            WHERE Id = :idAccount];

        AccountData accountData = new AccountData();
        accountData.account = anAccount;

        if (!anAccount.Contacts.isEmpty()) {
            accountData.principalContact = anAccount.Contacts.get(0);
        }
        if (!anAccount.Opportunities.isEmpty()) {
            accountData.lastOpportunity = anAccount.Opportunities.get(0);
        }
        
        return accountData;
    }
}
