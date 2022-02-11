@isTest
public with sharing class AccountManageTest {
    @istest
    private static void whenCheckOpportunityFieldInAccountCreateNewOpportunity() {
        Account anAccount = new Account(
            Name = 'Mr.Robinson'
        );
        insert anAccount;

        Test.startTest();
            anAccount.Opportunity__c = true;
            update anAccount;    
            
            Opportunity anOpportunity = [
                SELECT id, Name
                FROM Opportunity
                WHERE AccountId = :anAccount.Id
            ]; 
        Test.stopTest();

        System.assertEquals('Opportunity'+anAccount.Name+System.now().date(), anOpportunity.Name);
    }

    @isTest
    private static void updateAccountNamedCuentaDeEntrenamientoConIdentificationTypeNITYNewNumber() {
        Account anAccount = new Account(
            Name = 'Cuenta de Entrenamiento X',
            Identification_type__c = 'CC',
            Document_number__c = 'po789754654'
        );
        insert anAccount;
        
        Test.startTest();
            AccountManage.changeAccount();
            Account testAccount = [
                SELECT id, Identification_type__c, Document_number__c
                FROM Account
                WHERE id = :anAccount.Id 
            ];
        Test.stopTest();

        System.assertEquals(false, testAccount.Document_number__c==anAccount.Document_number__c);
        System.assertEquals('NIT', testAccount.Identification_type__c);
    }

    @isTest
    private static void createAnAccountUsingNameIdentificationTypeDocumentNumberNumberOfEmployeesAsParameters() {
        
        Test.startTest();
            String newAccountID = AccountManage.createAccount('newName', 100, 'NIT', 'newDocument_number');
            Account testAccount = [
                SELECT id, Name, Identification_type__c, Document_number__c, NumberOfEmployees
                FROM Account                
            ];
        Test.stopTest();

        System.assertEquals(true, testAccount.Id==newAccountID);
        System.assertEquals('newName', testAccount.Name);
        System.assertEquals(100, testAccount.NumberOfEmployees);
        System.assertEquals('newDocument_number', testAccount.Document_number__c);
    }

    @isTest
    private static void updateAnAccountUsingNameIdentificationTypeDocumentNumberNumberOfEmployeesAsParameters(){
        
        Account newAccount = new Account(
            Name='newName', 
            NumberOfEmployees= 100, 
            Identification_type__c ='NIT',
            Document_number__c = 'newDocument_number'
            );
        insert newAccount;
        
        Test.startTest();
            Boolean result = AccountManage.updateAccount('newName', 500, 'CC', 'differentDocument_number');
            Boolean resultFalse = AccountManage.updateAccount('otherName', 500, 'CC', 'differentDocument_number');
            Account testAccount = [
                SELECT id, Name, Identification_type__c, Document_number__c, NumberOfEmployees
                FROM Account                
            ];
        Test.stopTest();

        System.assertEquals(false, resultFalse);
        System.assertEquals(true, result);
        System.assertEquals(500, testAccount.NumberOfEmployees);
        System.assertEquals('differentDocument_number', testAccount.Document_number__c);
    }

    @isTest
    private static void deleteAnAccountUsingNameIdentificationTypeDocumentNumberAsParameters(){
        
        Account newAccount = new Account(
            Name='newName', 
            NumberOfEmployees= 100, 
            Identification_type__c ='CC',
            Document_number__c = 'differentDocument_number'
            );
        insert newAccount;
        
        Test.startTest();
            Boolean result = AccountManage.deleteAccount('CC', 'differentDocument_number');
            Boolean resultFalse = AccountManage.deleteAccount('CC', 'otherDocument_number');
            Boolean isDeleted = false;
            try{
                Account testAccount = [
                    SELECT id, Name, Identification_type__c, Document_number__c, NumberOfEmployees
                    FROM Account                
                ];
            }catch (Exception e){
                isDeleted = true;
            }
        Test.stopTest();

        System.assertEquals(false, resultFalse, 'Se pudo borrar y no debia');
        System.assertEquals(true, result, 'No se pudo borrar algo salio mal');
        System.assertEquals(true, isDeleted, 'El registro esta sin borrar');
        
    }

    @isTest
    private static void consultAnAccountUsingNameIdentificationTypeDocumentNumberAsParameters(){
        
        Account newAccount = new Account(
            Name='newName', 
            NumberOfEmployees= 100, 
            Identification_type__c ='CC',
            Document_number__c = 'differentDocument_number'
            );
        insert newAccount;
        
        Test.startTest();
            Account anAccount = AccountManage.consultAccount('CC', 'differentDocument_number');
            Account nullAccount = AccountManage.consultAccount('CC', 'otherDocument_number');
            
        Test.stopTest();

        System.assertEquals(null, nullAccount, 'Encontro Account y no debia');
        System.assertEquals(newAccount.id, anAccount.id);
        
    }
}
