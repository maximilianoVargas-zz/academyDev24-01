@RestResource(urlMapping='/Accounts/v1/*')
global with sharing class AccountService {

    @HttpGet
    global static String getAccountWithNamePrincipalAndOpportunity() {
        RestRequest request = RestContext.request;
        String caseId = request.requestURI.substring(
          request.requestURI.lastIndexOf('/')+1
        );

        String response;
        AccountService.DataAccountContactOpportunity respObject = new AccountService.DataAccountContactOpportunity(null, null, null);

        List<Account> accounts = [
            SELECT Id, Name
            FROM Account
            WHERE Id = :caseId
        ];

        if(accounts.size()>0) {            
            respObject.setAccountName(accounts.get(0).Name);
            
            List<Contact> contacts = [
                SELECT Id
                FROM Contact
                WHERE AccountId = :caseId
                AND Is_principal__c = true
            ];

            if(contacts.size()>0) {
                respObject.setPrincipalContactId(contacts.get(0).Id);
            }           

            List<Opportunity> opportunities = [
            SELECT Id, CreatedDate
            FROM Opportunity
            WHERE AccountId = :caseId
            ];
            if(opportunities.size()>0) {
                Opportunity anOpportunity = opportunities.get(0);
                for (Opportunity anOpp : opportunities) {
                    if(anOpp.CreatedDate > anOpportunity.CreatedDate){
                        anOpportunity = anOpp;
                    }
                }
                respObject.setLastOpportunityId(anOpportunity.Id);
            }

            response = respObject.parseToJson();

        } else {
            response = new AccountService.MessageError(caseId).parseToJson();
        }

        return response;
    }

    public class DataAccountContactOpportunity{
        private String AccountName;
        private String PrincipalContactId;
        private String LastOpportunityId;

        public DataAccountContactOpportunity(String AccountName, String PrincipalContactId, String LastOpportunityId){
            this.AccountName = AccountName ;
            this.PrincipalContactId = PrincipalContactId;
            this.LastOpportunityId = LastOpportunityId;
        }

        //getter and setter
        public String getAccountName(){
            return this.AccountName;
        }

        public void setAccountName(String AccountName){
            this.AccountName = AccountName;
        }

        public String getPrincipalContactId(){
            return this.PrincipalContactId;
        }

        public void setPrincipalContactId(String PrincipalContactId){
            this.PrincipalContactId = PrincipalContactId;
        }

        public String getLastOpportunityId(){
            return this.LastOpportunityId;
        }

        public void setLastOpportunityId(String LastOpportunityId){
            this.LastOpportunityId = LastOpportunityId;
        }

        public String parseToJson(){
            return '{' + 
                '"AccountName" : "' + AccountName + '", ' +
                '"PrincipalContactId" : "' + PrincipalContactId + '", ' +
                '"LastOpportunityId" : "' + LastOpportunityId + '"' +
            '}';
        }
    }

    public class MessageError{
        String Id;

        public MessageError(String id){
            this.Id = id;
        }

        public String parseToJson(){
            return '{"ErrorMessage" : "There are not accounts with the id: ' + Id + '"}';
        }
    }


}
