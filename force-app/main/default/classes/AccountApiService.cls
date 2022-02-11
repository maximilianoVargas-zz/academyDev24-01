@RestResource(urlMapping='/SpecialQuery/Account/')
global with sharing class AccountApiService {
    @HttpGet
    global static Account getAccountById(){
        //String idAccount = RestContext.request.params.get('Id');
        String idAccount = RestContext.request.requestURI.substring(RestContext.request.requestURI.lastIndexOf('/')+1);

        Account anAccount = [
            SELECT Name, (
                SELECT Id, Name
                FROM Contacts 
                WHERE Main_Contact__c = true
                LIMIT 1), (
                    SELECT Id, Name
                    FROM Opportunities 
                    ORDER BY CreatedDate DESC
                    LIMIT 1)
            FROM Account
            WHERE Id=:idAccount
        ];

        return anAccount;
        /*
        AccountResponse output = new AccountResponse();
        output.nameAccount=anAccount.Name;
        output.idMainContact=anAccount.Contacts[0].Name;
        output.idLastOpportunity=anAccount.Opportunities[0].Name;

        return output;
        */
    }

    /*
    global class AccountResponse{
        public String nameAccount {get; set;}
        public String idMainContact {get; set;}
        public String idLastOpportunity {get; set;}
    }
    */
}
