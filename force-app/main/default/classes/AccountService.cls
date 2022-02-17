@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountService {
    
    @HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request; 
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);
        List<Account> accounts = [
            SELECT id, Name, (select Id, Name FROM Contacts), (select Id, Name FROM Opportunities)
            FROM Account
            WHERE Id = :accountId
        ];
        if(accounts.size() == 0 || accounts.size() > 1) {
            return null;
        }
        return accounts.get(0);
    }

}
