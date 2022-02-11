@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountWebService {
    @HttpGet
    global static Account getAccountById() {
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account result =  [
            SELECT Name,(
                    SELECT FirstName, LastName 
                    FROM Contacts 
                    WHERE Principal_Contact__c = true
                    ),
                    (
                    SELECT Name 
                    FROM Opportunities 
                    ORDER BY CreatedDate 
                    DESC 
                    LIMIT 1
                    )
            FROM Account
            WHERE Id = :accountId
            ];
            
        return result;
    }
}