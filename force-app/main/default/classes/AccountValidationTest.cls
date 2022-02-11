@isTest
private class AccountValidationTest {

    @isTest static void errorMessageWhenCreatingAccountWithSameIdTypeAndNumber(){
        
        Account anAccount = new Account(
            Name = 'Mr.Robinson',
            Identification_type__c = 'NIT',
            Document_number__c = '11111111111'
        );
        insert anAccount;

        Account secondAccount = new Account(
            Name = 'Don Johnson',
            Identification_type__c = 'NIT',
            Document_number__c = '11111111111'
        );
                
        Test.startTest();
            Database.SaveResult result = database.insert(secondAccount, false);
        test.stopTest();

        
        System.assertNotEquals(true, result.isSuccess());
        System.assertEquals('Cannot create account with same id type and number', result.getErrors()[0].getMessage());
    }

    @isTest static void errorMessageWhenUpdateExistingAccountWithSameIdTypeAndNumber(){
        List<Account> accounts = new List<Account>();
        Account anAccount = new Account(
            Name = 'Mr.Robinson',
            Identification_type__c = 'NIT',
            Document_number__c = '11111111111'
        );
        accounts.add(anAccount);
        
        Account secondAccount = new Account(
            Name = 'Don Johnson',
            Identification_type__c = 'CC',
            Document_number__c = '11111111111'
        );
        accounts.add(secondAccount);

        insert accounts;


        Test.startTest();
            secondAccount.Identification_type__c = 'NIT';
            Database.SaveResult result = database.update(secondAccount, false);
        Test.stopTest();

        
        System.assertNotEquals(true, result.isSuccess());
        System.assertEquals('Cannot create account with same id type and number', result.getErrors()[0].getMessage());
    }
}
