@RestResource(urlMapping='/Account/*')
global with sharing class AccountService {
    @HttpGet
    global static Account getAccountById() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accountId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);

        Account anAccount =  [
            SELECT Id, Name, Principal_Contact__r.FirstName, Principal_Contact__r.LastName, (
                SELECT Id, Amount, CloseDate, Description, CreatedDate
                FROM Opportunities
                ORDER BY CreatedDate DESC limit 1
            )
            FROM account
            WHERE Id = :accountId
        ];
        return anAccount;    
    }
}