@RestResource(urlMapping='/Account/*')
global with sharing class ServiceToExpose {

    @HttpGet
    global static customWrapper getAccountPrincipalContactAndLastOppCreated() {

        RestRequest request = RestContext.Request;
        RestResponse response = RestContext.Response;
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);

        Account anAccount = [
            SELECT Id, Name
            FROM Account
            WHERE Id = :accountId
            LIMIT 1
        ];

        Contact aContact = [
            SELECT Id, LastName
            FROM Contact
            WHERE AccountId = :accountId
                AND Main_Contact__C = true
            LIMIT 1
        ];

        Opportunity anOpportunity = [
            SELECT Id, Name
            FROM Opportunity
            WHERE AccountId = :accountId
            ORDER BY CreatedDate Desc
            LIMIT 1
        ];

        customWrapper wrapper = new customWrapper(anAccount, aContact, anOpportunity);
        return wrapper;
    }

    global class customWrapper{
        public Account anAccount{get; set;}
        public Contact aContact{get; set;}
        public Opportunity anOpportunity{get; set;}

        public customWrapper(Account anAccount, Contact aContact, Opportunity anOpportunity){
            this.anAccount = anAccount;
            this.aContact = aContact;
            this.anOpportunity = anOpportunity;
        }
    }
}
