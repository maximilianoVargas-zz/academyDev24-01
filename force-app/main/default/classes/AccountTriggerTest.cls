@isTest
public with sharing class AccountTriggerTest {
    @isTest
    static void ifTriggerIsBeforeAndIsInsertCheckIfAccountIsAdded(){
        List<Account> anAccount = new List<Account>();
        anAccount.add(new Account(
            Name = 'Test1',
            Identification_type__c = 'NIT',
            Document_number__c = '12345678'
        ));

        Test.startTest();
        insert anAccount;
        Test.stopTest();

        List<Account> result = [
            SELECT Id, Name, Identification_type__c, Document_number__c
            FROM Account
            WHERE Document_number__c = '12345678'
        ];
        System.assertEquals(true, result.size() == 1,
        'Something went wrong when adding new accounts.');
    } 
    @isTest
    static void ifTriggerIsBeforeAndIsUpdateCheckIfAccountIsUpdated(){
        Account anAccount = new Account(
            Name = 'Test2',
            Identification_type__c = 'NIT',
            Document_number__c = '12345678'
        );
        insert anAccount;
        anAccount.Document_number__c = '87654321';

        Test.startTest();
        update anAccount;
        Test.stopTest();

        List<Account> result = [
            SELECT Id, Name, Identification_type__c, Document_number__c
            FROM Account
            WHERE Id = : anAccount.Id
            LIMIT 1
        ];
        System.assertEquals(true, result.size() == 1,
        'Something went wrong when updating accounts.');
    } 
}
