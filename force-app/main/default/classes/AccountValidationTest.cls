@isTest
public with sharing class AccountValidationTest {
    @isTest static void whenCreatingAnAccountThatIsNotValid() {
        Account anAccount1 = new Account(
            Name = 'account1',
            NumberOfEmployees = 3,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );

        insert anAccount1;

        Account anAccount2 = new Account(
            Name = 'account2',
            NumberOfEmployees = 5,
            Identification_type__c = 'NIT',
            Document_number__c = '1234567890' 
        );

        Boolean thereIsExeption = false;

        Test.startTest();
        try {
            insert anAccount2;
        } catch (DmlException e) {
            thereIsExeption = true;
        }
        Test.stopTest();

        System.assert(thereIsExeption);
    }

    @isTest static void whenUpdatingAnAccountThatIsNotValid() {

        //IT IS NOT POSIBLE BECAUSE DOCUMENT_NUMBER IS UNIQUE, 
        //SO IT CAN'T INSERT TWO ACCOUNTS WITH THE SAME DOCUMENT_NUMBER

        /* Account anAccount1 = new Account(
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

        insert accounts;

        String document_type = 'NIT';
        String document_number = '1234567890';

        Account anAccount3 = [
            SELECT Id, Name, Identification_type__c, Document_number__c
            FROM Account
            WHERE Identification_type__c = :document_type
            AND Document_number__c = :document_number
            LIMIT 1
        ];

        Boolean thereIsExeption = false;

        Test.startTest();
        try {
            update anAccount3;
        } catch (DmlException e) {
            thereIsExeption = true;
        }
        Test.stopTest();

        System.assert(thereIsExeption); */
    }
}
