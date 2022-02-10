@isTest
private class AccountValidationTest {

    @isTest static void errorMessageWhenCreatingAccountWithSameIdTypeAndNumber(){
        List<Account> accounts = new List<Account>();
        Account anAccount = new Account(
            Name = 'Mr.Robinson',
            Identification_type__c = 'NIT',
            Document_number__c = '11111111111'
        );
        Account secondAccount = new Account(
            Name = 'Don Johnson',
            Identification_type__c = 'NIT',
            Document_number__c = '11111111111'
        );
        Database.SaveResult[] results = database.insert(accounts, true);
        
        System.assertEquals('Cannot create account with same id type and number', results);

    }
}
