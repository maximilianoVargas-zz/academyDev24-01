@isTest
private with sharing class AccountValidationTest {
    @isTest
    static void testValidateAccount(){

        Account account = new Account(
            Name = 'TestAccount1',
            Identification_type__c = 'NIT',
            Document_number__c = '12345678'
        ); 
        insert account;   

        List<Account> accounts = new List<Account>(); 
        accounts.add(new Account(
            Name = 'TestAccount2',
            Identification_type__c = 'NIT',
            Document_number__c = '87654321'
        ));   
        accounts.add(new Account(
            Name = 'TestAccount3',
            Identification_type__c = 'NIT',
            Document_number__c = '12345678'
        ));
        accounts.add(new Account(
            Name = 'TestAccount4',
            Identification_type__c = Null,
            Document_number__c = Null
        ));
        
        Test.startTest();
        Database.SaveResult[] result = Database.insert(accounts,false);
        Test.stopTest();

        Integer errors = 0;
        for(Database.SaveResult resultcheck : result){
            if(resultcheck.isSuccess()==false){
                errors = errors + 1;
            }
        }
        
        System.assertEquals(2, errors, 'Something went wrong when returning true or false.');
    }
}