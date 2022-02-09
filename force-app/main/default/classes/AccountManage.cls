public with sharing class AccountManage {
    public static Object createAccount(String name,Integer employeesNumber,String identificationType, String documentNumber){
        Account account=new Account();
        account.Name=name;
        account.NumberOfEmployees=employeesNumber;
        account.IdentificationType__c=identificationType;
        account.DocumentNumber__c=documentNumber;
        insert account;
        System.debug(account.Id);
        return account.Id;
    }

    public static Boolean updateAccount(String name,Integer employeesNumber,String identificationType, String documentNumber){
        Account accountFound=[SELECT Id,Name,Active__c FROM Account WHERE IdentificationType__c = :identificationType and DocumentNumber__c = :documentNumber];
        accountFound.Name=name;
        accountFound.NumberOfEmployees=employeesNumber;
        update accountFound;
        return true;
    }

    public static Boolean deleteAccount(String identificationType, String documentNumber){
        Account accountFound=[SELECT Id,Name,Active__c FROM Account WHERE IdentificationType__c = :identificationType and DocumentNumber__c = :documentNumber];
        delete accountFound;
        return true;
    }

    public static Account consultAccount(String identificationType,String documentNumber){
        Account accountFound=[SELECT Id,Name,Active__c FROM Account WHERE IdentificationType__c = :identificationType and DocumentNumber__c = :documentNumber];
        return accountFound;
    }

    /*
Create an Apex class called AccountManage with the following methods
createAccount: Creates an account by receiving the name, number of employees, document type and document number. Returns the id of the new account

UpdateAccount: Updates an account by receiving the name, number of employees, document type and document number. Returns true if the account was updated or false if it was not updated.

DeleteAccount: Removes an account receiving the document type and number. Returns true if deleted or false if not deleted

ConsultAccount: Consult an account by receiving the document type and number. Return the account found or null if it does not exist.
    */
}