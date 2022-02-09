@isTest
public with sharing class AccountManageTest {
    @isTest static void testWhenCreateAnOpportunity() {
        Account carlos = generateAccount('carlos', 'NIT', '3214567890', true);
        Account carlitos = generateAccount('carlitos', 'NIT', '3214567891', false);
        Account carla = generateAccount('carla', 'NIT', '3214567892', true);
        List<Account> accounts = new List<Account>();
        accounts.add(carlos);
        accounts.add(carlitos);
        accounts.add(carla);
        insert accounts;
        Test.startTest();
        AccountManage.createOpportunity(accounts);
        Test.stopTest();
        List<Opportunity> oppCarlos = [
            SELECT Name, StageName, closeDate, AccountId
            FROM Opportunity
            WHERE AccountId = :carlos.Id
        ];
        List<Opportunity> oppCarlitos = [
            SELECT Name, StageName, closeDate, AccountId
            FROM Opportunity
            WHERE AccountId = :carlitos.Id
        ];
        List<Opportunity> oppCarla = [
            SELECT Name, StageName, closeDate, AccountId
            FROM Opportunity
            WHERE AccountId = :carla.Id
        ];  
        System.assert(!oppCarlos.isEmpty());
        System.assert(oppCarlitos.isEmpty());
        System.assert(!oppCarla.isEmpty());
        
    }




    private static Account generateAccount(String nombre, String tipo, String documento, Boolean crear_oportunidad) {
        return new Account(
            Name = nombre,
            Identification_type__c = tipo,
            Document_number__c = documento,
            Create_opportunity__c = crear_oportunidad
        );
    }
}