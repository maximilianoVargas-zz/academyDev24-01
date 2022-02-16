@isTest
public with sharing class AccountValidationTest {
    @isTest static void whenInsertAccountsWithTheSameIdentificationTypeAndDocumentNumber() {
        Account anAccount1 = new Account(
            Name = 'account1',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );
        Account anAccount2 = new Account(
            Name = 'account2',
            NumberOfEmployees = 4,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );

        List<Account> accounts = new List<Account>();
        accounts.add(anAccount1);
        accounts.add(anAccount2);

        Test.startTest();
        Database.SaveResult[] saveResult = Database.insert(accounts, false);
        Test.stopTest();

        System.assert(saveResult.get(0).isSuccess(), 'Error when insert the first account, the insert should be success');
        System.assertEquals(1, saveResult.get(1).getErrors().size(), 'The errors quantity does no match with the expected');
        System.assertEquals('There are another account with the same ' +
            + 'identification type and document number in the list', 
            saveResult.get(1).getErrors().get(0).getMessage(), 'The errors quantity does no match with the expected');
    }  
    
    @isTest static void whenUpdateAccountsWithTheSameIdentificationTypeAndDocumentNumber() {
        Account anAccount1 = new Account(
            Name = 'account1',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );
        Account anAccount2 = new Account(
            Name = 'account2',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567891' 
        );

        List<Account> accounts = new List<Account>();
        accounts.add(anAccount1);
        accounts.add(anAccount2);

        insert accounts;

        List<Account> accountsToUpdate = [
            SELECT Id, NumberOfEmployees, Identification_type__c, Document_number__c
            FROM Account
        ];
        
        for (Account anAccount : accountsToUpdate) {
            anAccount.Document_number__c = '1234567893';
        }
                
        Test.startTest();
            Database.SaveResult[] saveResult = Database.update(accountsToUpdate, false);
        Test.stopTest();

        System.assert(!saveResult.get(1).isSuccess(), 'The update should fail');
        System.assertEquals(1, saveResult.get(1).getErrors().size(), 'The errors quantity does no match with the expected');
        System.assertEquals(
            'There are another account with the same identification type and document number in the list', 
            saveResult.get(1).getErrors().get(0).getMessage(), 
            'The error message does not match'
        );
    }

    @isTest static void whenInsertAccountThatAlreadyExistsAnAccountWithTheSameIdentificationTypeAndDocumentNumber() {
        Account anAccount1 = new Account(
            Name = 'account1',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );

        insert anAccount1;

        Account anAccount2 = new Account(
            Name = 'account2',
            NumberOfEmployees = 4,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );

        Boolean thereIsExeption = false;

        Test.startTest();
            Database.SaveResult saveResult = Database.insert(anAccount2, false);
        Test.stopTest();

        System.assert(!saveResult.isSuccess(), 'The insert should fail');
        System.assertEquals(1, saveResult.getErrors().size(), 'The errors quantity does no match with the expected');
        System.assertEquals('The account already exists', saveResult.getErrors().get(0).getMessage(), 'The error message does not match');
    }  

    @isTest static void whenUpdateAccountThatAlreadyExistsAnAccountWithTheSameIdentificationTypeAndDocumentNumber() {
        Account anAccount1 = new Account(
            Name = 'account1',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );
        Account anAccount2 = new Account(
            Name = 'account2',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567891' 
        );

        List<Account> accounts = new List<Account>();
        accounts.add(anAccount1);
        accounts.add(anAccount2);

        insert accounts;

        Account accountToUpdate = [
            SELECT Id, NumberOfEmployees, Identification_type__c, Document_number__c
            FROM Account
            WHERE Id = :anAccount1.Id
            LIMIT 1
        ];

        accountToUpdate.Document_number__c = '1234567891';
                
        Test.startTest();
            Database.SaveResult saveResult = Database.update(accountToUpdate, false);
        Test.stopTest();

        System.assert(!saveResult.isSuccess(), 'The update should fail');
        System.assertEquals(1, saveResult.getErrors().size(), 'The errors quantity does no match with the expected');
        System.assertEquals(
            'Another account with the same document number and type already exists', 
            saveResult.getErrors().get(0).getMessage(), 
            'The error message does no match with the expected'
        );
    }
}
