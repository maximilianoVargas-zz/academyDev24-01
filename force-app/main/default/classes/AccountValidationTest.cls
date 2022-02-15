@isTest
public with sharing class AccountValidationTest {
    @TestSetup
    static void makeData(){
        List<Account> accounts=new List<Account>{
            new Account(Name='name1', DocumentNumber__c='46000081',IdentificationType__c='NIT',opportunity__c=true),
            new Account(Name='name2', DocumentNumber__c='46000082',IdentificationType__c='NIT',opportunity__c=true),
            new Account(Name='name3', DocumentNumber__c='46000083',IdentificationType__c='NIT',opportunity__c=true),
            new Account(Name='name4', DocumentNumber__c='46000084',IdentificationType__c='NIT',opportunity__c=true),
            new Account(Name='name5', DocumentNumber__c='46000085',IdentificationType__c='NIT',opportunity__c=false),
            new Account(Name='name6', DocumentNumber__c='46000086',IdentificationType__c='NIT',opportunity__c=true)
        };
        insert accounts;
    } 

    @isTest
    static void whenAnAccountIsInsertedWithANewDocumentNumberDocumentTypeShouldBeSuccess(){
        Account testAccount = new Account(Name='examplename100', DocumentNumber__c='34333342',IdentificationType__c='NIT');
        
        Test.startTest();
        Database.SaveResult result = Database.insert(testAccount,false);
        Test.stopTest();

        Account accountToValidate=[select DocumentNumber__c from Account where DocumentNumber__c='34333342'];

        System.assertEquals('34333342',accountToValidate.DocumentNumber__c);
        System.assertEquals(true,result.success,'insert have to be successfull');
    }

    @isTest
    static void whenAnAccountInInsertedWithAExistingDocumentNumberDocumentTypeShouldNotBeInseted(){
        Account testAccount = new Account(Name='examplename100', DocumentNumber__c='46000081',IdentificationType__c='NIT');

        Test.startTest();
        Database.SaveResult result= Database.insert(testAccount,false);
        Test.stopTest();

        System.assertEquals(false,result.success,'insert have to be false');
    }

    @isTest
    static void whenAnAccountIsUpdatedWithANewDocumentNumberDocumentTypeShouldBeSuccess(){
        Account accountToUpdate=[select Name,IdentificationType__c,DocumentNumber__c from Account where DocumentNumber__c='46000082'];
        accountToUpdate.DocumentNumber__c='46010004';
        
        Test.startTest();
        Database.SaveResult result = Database.update(accountToUpdate,false);
        Test.stopTest();

        Account accountToValidate=[select DocumentNumber__c from Account where DocumentNumber__c='46010004'];

        System.assertEquals('46010004',accountToValidate.DocumentNumber__c);
        System.assertEquals(true,result.success,'update have to be successfull');
    }

    @isTest
    static void whenAccountIsUpdatedWithAnExistingDocumentTypeDocumentNumberShouldNotBeUpdated(){
        Account accountToUpdate=[select Name,IdentificationType__c,DocumentNumber__c from Account where DocumentNumber__c='46000082'];
        accountToUpdate.DocumentNumber__c='46000084';
        
        Test.startTest();
        Database.SaveResult result = Database.update(accountToUpdate,false);
        Test.stopTest();

        System.assertEquals(false,result.success,'updated have to be false');
    }

    @isTest
    static void whenValidateAnAccountHasOpportunityValueSetAsTrueThenCreateOpportunity(){
        List<Account> accounts = [
            select Id,Name ,opportunity__c
            from Account
        ];
        List<Id> accountIds=new List<Id>();

        for (Account anAccount : accounts) {
            accountIds.add(anAccount.Id);
        }

        Test.startTest();
        AccountValidation.createOpportunity(accounts);
        Test.stopTest();

        List<Opportunity> opportunity=[
            select Id,AccountId from opportunity where AccountId in :accountIds
        ];

        //validar oportunidades creadas en base a cuentas insertadas que cumplen la condicion de opportunity__c = true
        System.assertEquals(5,opportunity.size());

        Account accountTest = [
            SELECT Id,Name
            FROM Account 
            WHERE DocumentNumber__c='46000081'
        ];

        Id accountId = accountTest.Id;

        Opportunity opportunityTest=[
            SELECT Id,StageName,CreatedDate,CloseDate,Name 
            FROM Opportunity 
            WHERE AccountId = :accountId
        ];
        
        //validar informacion de oportunidad creada
        System.assertEquals(opportunityTest.StageName, 'Prospection');
        System.assertEquals(opportunityTest.CloseDate.dayOfYear(), opportunityTest.CreatedDate.addMonths(1).dayOfYear());
        System.assertEquals(opportunityTest.Name,'Opportunity'+accountTest.Name+System.today());

    }
}
