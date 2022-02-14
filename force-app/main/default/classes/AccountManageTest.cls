@isTest
public with sharing class AccountManageTest {

    @IsTest static void CreateNewOpportunityMethod(){
        
        List<Account> Accounts= new List<Account>();

        Account anAccount =new Account();
        anAccount.create_opportunity__c=true;
        anAccount.Document_number__c='Test1234';
        anAccount.Identification_type__c='NIT';
        anAccount.name='Test';

        Accounts.add(anAccount);

        Test.startTest();
        AccountManage.createOpportunity(Accounts);
        Test.stopTest();
        

        Opportunity anOpportinity=[
            SELECT Name,StageName,CloseDate 
            FROM Opportunity 
            WHERE name like 'Opportunity%'
            LIMIT 1];

        System.assertEquals('Opportunity Test '+Date.TODAY(),anOpportinity.Name, 'The Name not match');
        System.assertEquals('Prospection',anOpportinity.StageName, 'The StageName not match');
        System.assertEquals(Date.TODAY()+30,anOpportinity.CloseDate, 'The Close Date not match');
    }

    @IsTest static void createAccountSuccess(){
        
        Test.startTest();
        string Response=AccountManage.createAccount('Test',100,'NIT','Test123456');
        Test.stopTest();

        Account anAccount=[
            SELECT Id
            FROM Account 
            WHERE Identification_type__c='NIT'
            AND Document_number__c='Test123456'
            LIMIT 1];

        System.assertEquals(anAccount.Id, Response,'The ID Dont match');
        
    }

    @IsTest static void createAccountDuplicate(){
        
        Test.startTest();
        AccountManage.createAccount('Test',100,'NIT','Test123456');
        string Response=AccountManage.createAccount('Test',100,'NIT','Test123456');
        Test.stopTest();

        Account anAccount=[
            SELECT Id
            FROM Account 
            WHERE Identification_type__c='NIT'
            AND Document_number__c='Test123456'
            LIMIT 1];

        System.assertEquals('El Usuario ya Existe', Response,'The User Already exist');
    }

    @IsTest static void ConsultAccount(){
        
        Account anAccount=new Account();
        anAccount.Name='Test';
        anAccount.Identification_type__c='NIT';
        anAccount.NumberOfEmployees=100;
        anAccount.Document_number__c='Test123456';
        insert anAccount;

        Test.startTest();
        Account AccountResponse=AccountManage.ConsultAccount(anAccount.Identification_type__c,anAccount.Document_number__c);
        Test.stopTest();

        System.assertEquals(anAccount.Name, AccountResponse.Name,'The Consult dont get result');
    }

    @IsTest static void UpdateAccount(){
        
        Account anAccount=new Account();
        anAccount.Name='Test';
        anAccount.Identification_type__c='NIT';
        anAccount.NumberOfEmployees=100;
        anAccount.Document_number__c='Test1234567';
        insert anAccount;

        Test.startTest();
        Boolean AccountResponse=AccountManage.UpdateAccount(anAccount.Name,200,anAccount.Identification_type__c,anAccount.Document_number__c);
        Test.stopTest();

        Account anAccountUpdate=[
            SELECT Name,NumberOfEmployees,Identification_type__c,Document_number__c
            FROM Account 
            WHERE Identification_type__c='NIT'
            AND Document_number__c='Test1234567'
            LIMIT 1];
        
        System.assertEquals(200, anAccountUpdate.NumberOfEmployees,'The Data was not Update');
        System.assertEquals(true, AccountResponse,'The Response from the update was False');
    }

    @IsTest static void DeleteAccount(){
        
        Account anAccount=new Account();
        anAccount.Name='Test';
        anAccount.Identification_type__c='NIT';
        anAccount.NumberOfEmployees=100;
        anAccount.Document_number__c='Test1234567';
        insert anAccount;

        Test.startTest();
        Boolean AccountResponse1=AccountManage.DeleteAccount(anAccount.Identification_type__c,anAccount.Document_number__c);
        Account AccountResponse2=AccountManage.ConsultAccount(anAccount.Identification_type__c,anAccount.Document_number__c);
        Test.stopTest();

        System.assertEquals(true, AccountResponse1,'The Account was not delete');
        System.assertEquals(null, AccountResponse2,'The Account continue exist');
    }
}
