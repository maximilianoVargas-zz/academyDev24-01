/* Problem: We need to create a new service class, in this class we need to creates 
a function to expose a Rest Api.
this function receive a String this represent of id in an account, with this id 
need to get name, the principal contact, and the last opportunity created
when you received the data from database create a response with it

 */
@RestResource(urlMapping='/Account/*')
global with sharing class ExposingApiRestService {
    @HttpGet
    global static Contact getAccountById() {
        RestRequest request = RestContext.request;
        // grab the caseId from the end of the URL
        String accountId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1);
        Account anAccount =  [
            SELECT Id, (SELECT id, LastName FROM contacts)
            FROM Account
            WHERE Id = :accountId];

        Contact firstContact;
        for(Contact aContact:anAccount.Contacts){
            firstContact = aContact;
            break;
        }
        return firstContact;
       
    }
}