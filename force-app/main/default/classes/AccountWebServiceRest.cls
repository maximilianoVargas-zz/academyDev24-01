@RestResource(urlMapping='/Account/*')
global with sharing class AccountWebServiceRest {
    @HttpPost
    global static string getAccountById(string Id) {
        
    try {

            Response response=new Response();
            List<Account> anAccount=[
                SELECT Id,Name 
                FROM Account 
                WHERE Id=:id
            ];
            
            List<Contact> aContact=[
                SELECT Id 
                FROM Contact 
                WHERE AccountId=:anAccount.get(0).Id
                AND isPrincipal__c=true
            ];
            
            List<Opportunity> anOpportunity=[
                SELECT Id,name,AccountId,CreatedDate 
                FROM Opportunity 
                WHERE AccountId=:anAccount.get(0).Id 
                ORDER BY CreatedDate desc
                LIMIT 1
            ];

                if(anAccount.size()>0  && aContact.size()>0 && anOpportunity.size()>0)
                    return response.getResponse(anAccount.get(0).Name,aContact.get(0).Id,anOpportunity.get(0).Id);
                
                else
                    return 'The Id Dont have any opportunity or an account asociate';               
        } 
        
        catch (DmlException e) {
            return string.valueOf(e);
        }   
    } 

    public class Response{

        public string getResponse(string name,string principalContact,string lastOpportunity){
    
            string json='{"Name Of Account":'+name+'",Principal Contac:"'+principalContact+'",Id Last Opportunity:"'+lastOpportunity+'}';
            return json;
        }
    }
}


