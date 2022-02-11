@RestResource(urlMapping='/AccountsCustom/*')
global with sharing class AccountManager {
    @HttpGet
    global static ResponseWrapper getAccountDetails(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/')+1
        );
        Account anAccount = [
            SELECT Name
            FROM Account
            WHERE Id = :accountId
            WITH SECURITY_ENFORCED
        ];

        Contact aContact = [
            SELECT FirstName, LastName
            FROM Contact
            WHERE AccountId = :accountId
            AND Principal__c = True
            WITH SECURITY_ENFORCED
            LIMIT 1
        ];

        Opportunity anOpportunity = [
            SELECT Id, Name
            FROM Opportunity
            WHERE AccountId = :accountId
            WITH SECURITY_ENFORCED
            ORDER BY CreatedDate DESC
            LIMIT 1
        ];

        ResponseWrapper response = new ResponseWrapper(anAccount, aContact, anOpportunity);

        return response;
    }

    global class ResponseWrapper{
        public Account anAccount {get; set;}
        public Contact aContact {get; set;}
        public Opportunity anOportunuty {get; set;}

        public ResponseWrapper(Account anAccount, Contact aContact, Opportunity anOportunuty){
            this.anAccount = anAccount;
            this.aContact = aContact;
            this.anOportunuty = anOportunuty;
        }
    }

}
