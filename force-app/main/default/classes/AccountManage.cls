public with sharing class AccountManage {
    public AccountManage() {

    }

    public static String createAccount(String name, Integer numberOfEmployees, 
                                    String identificationType, String documentNumber) {
        Account account1 = new Account();
        account1.Name = name;
        account1.NumberOfEmployees = numberOfEmployees;
        account1.Identification_type__c = identificationType;
        account1.Document_number__c = documentNumber;

        insert account1;
        System.debug(account1.Id);
        return  account1.Id;
    }

    public static Boolean updateAccount(String name, Integer numberOfEmployees, 
                                    String identificationType, String documentNumber) {
                                  
        Account acc = [SELECT Name, NumberOfEmployees,
         Identification_type__c, Document_number__c 
         FROM Account 
         WHERE Name =: name];
        
         acc.NumberOfEmployees = numberOfEmployees;
         acc.Identification_type__c = identificationType;
         acc.Document_number__c = documentNumber;

        Database.SaveResult result = Database.update(acc,false);
        System.debug(result.isSuccess());
        return result.isSuccess();
    }

    public static Boolean deleteAccount(String identificationType, String documentNumber) {
                                  
        Account acc = [SELECT Identification_type__c, Document_number__c 
         FROM Account 
         WHERE Document_number__c =: documentNumber];

        Database.DeleteResult result = Database.delete(acc,false);
        System.debug(result.isSuccess());
        return result.isSuccess();
    }

    public static Account consultAccount(string documentType, string documentNumber){
        try{

            Account acc = [
                SELECT Id, Name, numberOfEmployees, 
                    Identification_type__c, Document_Number__c
                FROM Account 
                WHERE Identification_type__c = :documentType 
                AND Document_Number__c = :documentNumber
                LIMIT 1
            ];

            return acc;
        } catch(Exception e){
            return null;
        }
    } 

}