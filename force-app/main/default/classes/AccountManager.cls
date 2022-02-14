@RestResource(urlMapping='/Account/Details/*')
global with sharing class AccountManager {
    @HttpGet
    global static WrapperResponse getAccountDetail(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1);
        Account anAccount = [
            SELECT Name
            FROM Account
            WHERE Id = :accountId
        ];

        Contact aContact = [
            SELECT FirstName, LastName
            FROM Contact
            WHERE AccountId = :accountId
            AND Principal_Contact__c = true
        ];

        Opportunity anOpportunity = [
            SELECT Id, Name
            FROM Opportunity
            WHERE AccountId = :accountId
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];

        WrapperResponse response = new WrapperResponse(anAccount, aContact, anOpportunity);

        return response;
    }

    global class WrapperResponse{
        public Account anAccount {get; set;}
        public Contact aContact {get; set;}
        public Opportunity anOpportunity {get; set;}

        public WrapperResponse(Account anAccount, Contact aContact, Opportunity anOpportunity){
            this.anAccount = anAccount;
            this.aContact = aContact;
            this.anOpportunity = anOpportunity;
        }
    }


}

/*@RestResource(urlMapping='/Accounts/*/
/*contacts')
global without sharing class AccountManager {
    @HttpGet
    global static Account getAccount() {
        Account anAccount;
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substringBetween('Accounts/','/contacts');

            if (!String.isEmpty(accountId) ) {
                anAccount = [
                    SELECT Id, Name,(select Id, Name from contacts) 
                    FROM Account 
                    WHERE id = :accountId];
            }

            return anAccount;
    }
}*/
