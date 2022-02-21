@isTest
public class AccountValidationTest {
   @TestSetup
   static void makeData(){
        List<Account> accounts = new List<Account>();
        Account testAccount = new Account(Name='Test Account', 
                                        NumberOfEmployees=10, 
                                        Identification_Type__c='NIT', 
                                        Document_Number__c='0123456789');
        accounts.add(testAccount);
        
        Account secondTestAccount = new Account(Name='Another Test Account', 
                                        NumberOfEmployees=20, 
                                        Identification_Type__c='NIT', 
                                        Document_Number__c='9876543210');
        accounts.add(secondTestAccount);
        
        insert accounts;
   }
   
    @isTest static void shouldAllowAddingThisAccount(){
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='TestAccount', 
                                NumberOfEmployees=10,  
                                Identification_Type__c='NIT', 
                                Document_Number__c='012345678900'));
        Test.startTest();
        List<Database.SaveResult> result = Database.insert(accounts, false);
        Test.stopTest();

        System.assertEquals(true, result[0].isSuccess(), 'Something went bad. Couldnt insert new account.');
    }

    @isTest static void shouldNotAllowAddingThisAccount(){
        List<Account> accounts = new List<Account>();
        accounts.add(new Account(Name='Same as Test Account', 
                                NumberOfEmployees=10,  
                                Identification_Type__c='NIT', 
                                Document_Number__c='0123456789'));
        Test.startTest();
        List<Database.SaveResult> result = Database.insert(accounts, false);
        Test.stopTest();

        System.assertEquals(false, result[0].isSuccess(), 'Something went bad. Inserted an equal account.');
        System.assertEquals('Cuenta ya existente en base de datos!', result[0].getErrors()[0].getMessage(), 
                                'Something went bad. Inserted an equal account.');
    }

    @isTest static void shouldAllowUpdatingThisAccount(){
        Account anAccount = [
            SELECT NumberOfEmployees
            FROM Account
            WHERE Document_Number__c = '0123456789'
        ];
        anAccount.NumberOfEmployees = 15;

        Test.startTest();
        Database.SaveResult result = Database.update(anAccount, false);
        Test.stopTest();

        System.assertEquals(true, result.isSuccess(), 'Something went bad. Couldnt update account.');
    }

    @isTest static void shouldNotAllowUpdatingThisAccount(){
        Account anAccount = [
            SELECT Document_Number__c
            FROM Account
            WHERE Document_Number__c = '0123456789'
        ];
        anAccount.Document_Number__c = '9876543210';

        Test.startTest();
        Database.SaveResult result = Database.update(anAccount, false);
        Test.stopTest();

        System.assertEquals(false, result.isSuccess(), 'Something went bad. Updated account with existing values.');
        System.assertEquals('Cuenta ya existente en base de datos!', result.getErrors()[0].getMessage(), 
                                'Something went bad. Updated account with existing values.');
    }
}
