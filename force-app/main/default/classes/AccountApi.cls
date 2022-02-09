@RestResource(urlMapping='/Accounts/contacts')
global with sharing class AccountApi {
    @HttpGet
    global static Account getAccount(){

        List<Account> accounts = new List<Account>();
        accounts=[SELECT Id, Name ,(SELECT Id, Name FROM Contacts) FROM Account limit 5];

        return accounts[0];
    }
}
/*
First exercise:

Problem: We need to create a new service class, in this class we need to creates a function to expose a Rest Api.
this function receive a String this represent of id in an account, with this id need to get name, the principal contact, and the last opportunity created
when you received the data from database create a response with it

*/