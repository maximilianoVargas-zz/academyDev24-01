@IsTest
public with sharing class AccountManageTest {
 

    @IsTest
    public static void whenCreateOpportunityWhenCreaterOpportunityFieldIsTrue(){

        List<Account> accounts = new List<Account>();
        for(Integer i = 0;  i<20 ; i++){
            accounts.add(
                new Account(
                    Name = 'test ' +i,
                    create_opportunity__c = true
                )
            );
        }

        Test.startTest();
        AccountManage.createOpportunity(accounts);
        Test.stopTest();

        List<Opportunity> opportunities = [
            SELECT Id, AccountId FROM Opportunity WHERE AccountId IN :accounts
        ];

        System.assertEquals(20, opportunities.size(), 
        'La cantidad de oportunidades creadas no es igual a la cantidad de cuentas con el campo create_oportunity en True');

    }

    @IsTest
    public static void whenUpdateAnAccountThatHasAnExistingDocumentIdentificationAndType(){

        List<Account> accounts = new List<Account>();
        for(Integer i = 0;  i<20 ; i++){
            accounts.add(
                new Account(
                    Name = 'test ' +i,
                    Document_number__c = 'id' +i,
                    Identification_type__c = 'CC'
                )
            );
        }

        insert accounts;

        Account anAccount = accounts.get(0);
        anAccount.Document_number__c = accounts.get(1).Document_number__c;

        Test.startTest();
        Database.SaveResult result = Database.update(anAccount, false);
        Test.stopTest();

        System.assert(result.getErrors().size()!=0, 'Se esperaba un error por tratar de actualizar una cuenta con un numero de identificación existente');

    }

    @IsTest
    public static void whenInsertAnAccountThatHasAnExistingDocumentIdentificationAndType(){

        List<Account> accounts = new List<Account>();
        for(Integer i = 0;  i<20 ; i++){
            accounts.add(
                new Account(
                    Name = 'test ' +i,
                    Document_number__c = 'id' +i,
                    Identification_type__c = 'CC'
                )
            );
        }

        insert accounts;

        Account anAccount = new Account(
            Document_number__c = accounts.get(1).Document_number__c,
            Identification_type__c = accounts.get(1).Identification_type__c
        );
        

        Test.startTest();
        Database.SaveResult result = Database.insert(anAccount, false);
        Test.stopTest();

        System.assert(result.getErrors().size()!=0, 'Se esperaba un error por tratar de actualizar una cuenta con un numero de identificación existente');

    }

}