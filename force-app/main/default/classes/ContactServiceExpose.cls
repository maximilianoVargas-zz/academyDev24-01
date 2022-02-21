@RestResource(urlMapping = '/accountService/*')
global with sharing class ContactServiceExpose {
    
    @HttpGet
    global static CustomContactWrapper getNamePrincicalAndLastOppurtunity(){
        RestRequest request = RestContext.request;
        String accountId = request.requestURI.substring(
            request.requestURI.lastIndexOf('/') +1
        );

        Account anAccount = [
            SELECT Id, Name,
            (SELECT FirstName, LastName FROM Contacts LIMIT 1),
            (SELECT Id, Name FROM Opportunities ORDER BY CreatedDate DESC LIMIT 1)
            FROM Account
            WHERE Id = :accountId
        ];


        Contact aContact = New Contact(FirstName = 'No diponible');
        if(!anAccount.Contacts.isEmpty()){
            aContact =  anAccount.Contacts.get(0);
        }

        Opportunity anOppotunity = new Opportunity(Name = 'No disponible');
        if(!anAccount.Opportunities.isEmpty()){
            anOppotunity = anAccount.Opportunities.get(0);
        }

        CustomContactWrapper contactWrapper = new CustomContactWrapper(
            anAccount.Name,
            aContact,
            anOppotunity
        );

        return contactWrapper;
    }

    global class CustomContactWrapper{
        public String Name{get;set;}
        public Contact principalContact{get;set;}
        public Opportunity LastOpportunity{get; set;}
        public CustomContactWrapper(String Name, Contact aContact, Opportunity opportunity){
            this.Name = Name;
            this.principalContact = aContact;
            this.LastOpportunity = opportunity;
        }
    }

}
