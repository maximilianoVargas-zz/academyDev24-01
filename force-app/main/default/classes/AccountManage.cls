/*
createAccount: Creates an account by receiving the name, number of employees, document type and document number. Returns the id of the new account
UpdateAccount: Updates an account by receiving the name, number of employees, document type and document number. Returns true if the account was updated or false if it was not updated.
DeleteAccount: Removes an account receiving the document type and number. Returns true if deleted or false if not deleted
ConsultAccount: Consult an account by receiving the document type and number. Return the account found or null if it does not exist.

*Name = "Opportunity" + account name + current date
Stage = "Prospection”
ClosedDate = current date + 30 days */

public with sharing class AccountManage {
    public static void changeAccount() {
        List<Account> lastAccounts = [
            SELECT Id, Identification_type__c, Document_number__c
            FROM Account
            WHERE name LIKE 'Cuenta de entrenamiento _' 
        ];
        for (Account anAccount: lastAccounts){

            anAccount.Identification_type__c = 'NIT';
            anAccount.Document_number__c = EncodingUtil.base64encode(Crypto.generateAesKey(192)).substring(0, 10);
        }
        System.debug(lastAccounts);
        update lastAccounts;
    }
    public static String createAccount(String newName, Integer newEmployees, String newDocument_type, String newDocument_number) {
        Account anAccount = new Account(
            Name = newName,
            NumberOfEmployees = newEmployees,
            Document_number__c = newDocument_number,
            Identification_type__c = newDocument_type
        );
        insert anAccount;
        return anAccount.Id;
    }

    public static Boolean updateAccount(String aName, Integer newEmployees, String newDocument_type, String newDocument_number) {
        try {
            Account anAccount = [
            SELECT id, name, NumberOfEmployees, Document_number__c, Identification_type__c
            FROM Account
            WHERE Name = :aName
            LIMIT 1];
        
            anAccount.NumberOfEmployees = newEmployees;
            anAccount.Document_number__c = newDocument_number;
            anAccount.Identification_type__c = newDocument_type;
            Database.SaveResult result = Database.update(anAccount);
            return result.isSuccess();

        } catch (Exception e) {
            return false;
        }
    }    

    public static Boolean deleteAccount(String newDocument_type, String newDocument_number) {
        try {
            Account anAccount = [
                SELECT id, name
                FROM Account
                WHERE Document_number__c = :newDocument_number
                AND Identification_type__c = :newDocument_type
                LIMIT 1
             ];
            Database.DeleteResult result = Database.delete(anAccount);
            return result.isSuccess();

        } catch (Exception e) {
            return false;
        }
    }

    public static Account consultAccount(String newDocument_type, String newDocument_number) {
        try {
            return [
                SELECT id, name
                FROM Account
                WHERE Document_number__c = :newDocument_number
                AND Identification_type__c = :newDocument_type
                LIMIT 1
                ];
        } catch (Exception e) {
            return null;   
            }
    }    
    public static void createOpportunity(List<Account> accounts) {

        List<Opportunity> opportsToCreate = new List<Opportunity>();
        for(Account anAccount:accounts){
            if(anAccount.Opportunity__c==true){
                Opportunity newOpport = new Opportunity(
                    AccountId = anAccount.Id,
                    StageName = 'Prospection',
                    Name = 'Opportunity'+anAccount.Name+System.now().date(),
                    CloseDate = System.now().date() + 30
                );
                opportsToCreate.add(newOpport);
            }
        }
        insert opportsToCreate;    

    }
}
