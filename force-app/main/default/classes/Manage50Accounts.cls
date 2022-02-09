/*APEX Practice (1 Hour)
Create in the object counts the following fields:
Identification type: List field with the values CC, TI, PP, NIT
Document number: Text fields with a length of 30 characters
Create an Apex language script that queries the 50 accounts created and updates the 
Identification type fields with the NIT value and Document number with a 10-digit random number.
EncodingUtil.base64encode(Crypto.generateAesKey(192)).substring(0, 10);

Create an Apex class called AccountManage with the following methods
createAccount: Creates an account by receiving the name, number of employees, document type and document number. Returns the id of the new account
UpdateAccount: Updates an account by receiving the name, number of employees, document type and document number. Returns true if the account was updated or false if it was not updated.
DeleteAccount: Removes an account receiving the document type and number. Returns true if deleted or false if not deleted
ConsultAccount: Consult an account by receiving the document type and number. Return the account found or null if it does not exist.
 */
public with sharing class Manage50Accounts {
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
    public static void createAccount(String newName, Integer newEmployees, String newDocument_type, String newDocument_number) {
        Account anAccount = new Account(
            Name = newName,
            NumberOfEmployees = newEmployees,
            Document_number__c = newDocument_number,
            Identification_type__c = newDocument_type
        );
        insert anAccount;
    }

    public static void updateAccount(String aName, Integer newEmployees, String newDocument_type, String newDocument_number) {
        Account anAccount = [
            SELECT id, name, NumberOfEmployees, Document_number__c, Identification_type__c
            FROM Account
            WHERE Name = :aName
            LIMIT 1
        ];

        anAccount.NumberOfEmployees = newEmployees;
        anAccount.Document_number__c = newDocument_number;
        anAccount.Identification_type__c = newDocument_type;
        try {
            Database.SaveResult result = Database.update(anAccount);
            System.debug('Actualizacion:'+ result.isSuccess());

        } catch (Exception e) {
            System.debug('Actualizacion: False'+' Error:'+e);
        }
          
    }    

    public static void deleteAccount(String newDocument_type, String newDocument_number) {
        Account anAccount = [
            SELECT id, name
            FROM Account
            WHERE Document_number__c = :newDocument_number
            AND Identification_type__c = :newDocument_type
            LIMIT 1
        ];

        try {
            Database.DeleteResult result = Database.delete(anAccount);
            System.debug('Actualizacion:'+ result.isSuccess()+ ' se borro'+ anAccount.Name);

        } catch (Exception e) {
            System.debug('Actualizacion: False'+' Error:'+e);
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
}

