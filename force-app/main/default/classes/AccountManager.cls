@RestResource(urlMapping='/Accounts/*/contacts')
global class AccountManager {
    @HttpGet
    global static Account getAccount(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substringBetween('Accounts/','/contacts');
        Account Result = [SELECT Id, Name, (SELECT Id, Name From Contacts) From Account Where Id =: accountId];
        Return Result;
    }
}