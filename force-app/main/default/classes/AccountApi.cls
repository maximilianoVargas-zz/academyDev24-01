@RestResource(urlMapping='/AccountsApi/*')
global with sharing class AccountApi {

    @HttpGet
    global static Account getAccountById(){
        string idAccount = RestContext.request.params.get('Id');

        Account anAccount = [
            SELECT Id, Name, (
                SELECT Name, Email
                FROM Contacts
                WHERE Contacto_Principal__c = true
            ),(
                SELECT Name 
                FROM Opportunities
                ORDER BY CreatedDate DESC 
                LIMIT 1                
            )
            FROM Account
            WHERE Id = :idAccount
        ];        
        return anAccount;
    }
}