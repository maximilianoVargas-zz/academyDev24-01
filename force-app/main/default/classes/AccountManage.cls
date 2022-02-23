public with sharing class AccountManage {

    public static string createAcccount(
            string name, integer numberOfEmployees, 
            string documentType, string documentNumber
            ){
                Account anAccount =  new Account(
                    name = name,
                    numberOfEmployees = numberOfEmployees,
                    Identification_type__c = documentType,
                    Document_Number__c = documentNumber
                );
                insert anAccount;
                return anAccount.Id;
    }

    public static Boolean updateAccount(
        string name, integer numberOfEmployees, 
        string documentType, string documentNumber
    ){
        Account anAccount = consultAccount(documentType, documentNumber);
        anAccount.Name = name;
        anAccount.numberOfEmployees = numberOfEmployees;
        Database.SaveResult result = Database.update(anAccount,false);

        return result.isSuccess();
    }

    public static Boolean deleteAccount(
        string documentType, string documentNumber
    ){
        Account anAccount = consultAccount(documentType, documentNumber);
        Database.DeleteResult result = Database.delete(anAccount,false);

        return result.isSuccess();
    }


    public static Account consultAccount(string documentType, string documentNumber){
        try{
            return [
                SELECT Id, name, numberOfEmployees, 
                    Identification_type__c, Document_Number__c
                FROM Account 
                WHERE Identification_type__c = :documentType 
                AND Document_Number__c = :documentNumber
                LIMIT 1
            ];
        } catch(Exception e){
            return null;
        }
    }

    public static void createOpportunity(List<Account> accounts){
        List<Opportunity> opportunitiesToCreate = new List<Opportunity>();
        for(Account anAccount : accounts){
            if(anAccount.Create_Opportunity__c  == true){
                Opportunity anOpportunity       = new Opportunity();
                anOpportunity.AccountId         = anAccount.Id;
                anOpportunity.Name              = 'Opportunity ' + anAccount.Name + '' + Date.today();
                anOpportunity.StageName         = 'Prospection';
                anOpportunity.CloseDate         = Date.today().addDays(30);

                opportunitiesToCreate.add(anOpportunity);
            }
        }
        insert opportunitiesToCreate;
    }
}