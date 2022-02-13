public with sharing class AccountManage {
    public static String createAccount(String name, Integer numberOfEmployees, String identificationType, String documentNumber) {

        Account anAccount = new Account(
            Name = name,
            NumberOfEmployees = numberOfEmployees,
            Identification_type__c = identificationType,
            Document_number__c = documentNumber
        );
        insert anAccount;
        return  anAccount.Id;
    }
    public static Boolean updateAccount(String name, Integer numberOfEmployees, String identificationType, String documentNumber) {
                                    
        Account anAccount = [
            SELECT Name, NumberOfEmployees, Identification_type__c, Document_number__c 
            FROM Account 
            WHERE Name =: name
        ];
        anAccount.NumberOfEmployees = numberOfEmployees;
        anAccount.Identification_type__c = identificationType;
        anAccount.Document_number__c = documentNumber;

        Database.SaveResult result = Database.update(anAccount, false);
        return result.isSuccess();
    }
    public static Boolean deleteAccount(String identificationType, String documentNumber) {
                                    
        Account anAccount = [
            SELECT Identification_type__c, Document_number__c 
            FROM Account 
            WHERE Document_number__c =: documentNumber
        ];
        Database.DeleteResult result = Database.delete(anAccount,false);
        return result.isSuccess();
    }
    public static Account consultAccount(string identificationType, string documentNumber){

        try{
            Account anAccount = [
                SELECT Id, Name, numberOfEmployees, Identification_type__c, Document_Number__c
                FROM Account 
                WHERE Identification_type__c = :identificationType 
                AND Document_Number__c = :documentNumber
            ];

            return anAccount;
        } catch(Exception e){
            return null;
        }
    } 
    public static List<Opportunity> createOpportunity(List<Account> Accounts) {

        List<Opportunity> oppList = new List<Opportunity>();
        for (Account anAccount : Accounts){
            if(anAccount.Create_Opportunity__c){
                oppList.add(new Opportunity(
                    AccountId = anAccount.Id,
                    Name = anAccount.Name + Date.Today(),
                    StageName = 'Prospection',
                    CloseDate = Date.Today().addDays(30)
                ));
            }
        }
        insert oppList;
        return oppList;
    }
}