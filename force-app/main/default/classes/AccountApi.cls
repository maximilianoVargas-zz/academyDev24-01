@RestResource(urlMapping='/Accountjd/*')
global with sharing class AccountApi {
    @HttpGet
    global static Account getAccountById(){
        RestRequest request=RestContext.request;
        String accountId=request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);
        System.debug('account id: '+ accountId);

        Account account =[
            SELECT Id,Name,(
                SELECT Id,FirstName,Level__c 
                FROM Contacts  
                WHERE AccountId=:accountId AND Level__c='Primary'
            ),(
                SELECT Description,CreatedDate 
                FROM Opportunities 
                WHERE AccountId=:accountId ORDER BY CreatedDate DESC 
                LIMIT 1
            ) 
            FROM Account 
            WHERE Id=:accountId
        ];

        return account;
    }
}

/*
First exercise:

Problem: We need to create a new service class, in this class we need to creates a function to expose a Rest Api.
this function receive a String this represent of id in an account, with this id need to get name, the principal contact, and the last opportunity created
when you received the data from database create a response with it

*/