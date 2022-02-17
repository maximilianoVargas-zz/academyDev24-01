@IsTest
private class AccountTriggerTest {
    @TestSetup
    static void makeData(){
        Account anAccount =  new Account(
			Name = 'My Account',
			NumberOfEmployees = 99,
			Identification_type__c = 'NIT',
			Document_Number__c = '123'
		);
        insert anAccount;
    }
    @IsTest
    static void createAccountWithNewIds() {
        Account anAccount =  new Account(
			Name = 'My Account new',
			NumberOfEmployees = 99,
			Identification_type__c = 'NIT',
			Document_Number__c = '456'
		);
        Test.startTest();
        insert anAccount;
        Test.stopTest();
        List<Account> accounts = [
            SELECT Name, NumberOfEmployees, Identification_type__c,	Document_Number__c
            FROM Account
            WHERE Name = 'My Account new'
        ];
        System.assertEquals(1, accounts.size(), 'No se ha guardado la cuenta nueva o no es la unica.');
    }
    @IsTest
    static void createAccountWithSameIds() {
        Account anAccount =  new Account(
			Name = 'My Account new',
			NumberOfEmployees = 99,
			Identification_type__c = 'NIT',
			Document_Number__c = '123'
		);
        Test.startTest();
        Database.SaveResult result = Database.insert(anAccount, false);
        Test.stopTest();
        List<Account> accounts = [
            SELECT Name, NumberOfEmployees, Identification_type__c,	Document_Number__c
            FROM Account
            WHERE Name = 'My Account new'
        ];
        System.assertEquals(false, result.isSuccess(), 'Ha insertado la cuenta a pesar de tener mismos tipo y numero de documento.');
        System.assertEquals(0, accounts.size(), 'Ha insertado la cuenta a pesar de tener mismos tipo y numero de documento.');
    }
    @IsTest
    static void createAccountWithMixIds() {
        Account anAccount1 =  new Account(
			Name = 'My Account new',
			NumberOfEmployees = 99,
			Identification_type__c = 'NIT',
			Document_Number__c = '123'
		);
        Account anAccount2 =  new Account(
			Name = 'My Account new',
			NumberOfEmployees = 99,
			Identification_type__c = 'NIT',
			Document_Number__c = '456'
		);
        List<Account> accounts = new List<Account>();
        accounts.add(anAccount1);
        accounts.add(anAccount2);
        Test.startTest();
        List<Database.SaveResult> result = Database.insert(accounts, false);
        Test.stopTest();
        List<Account> accountsToCompare = [
            SELECT Name, NumberOfEmployees, Identification_type__c,	Document_Number__c
            FROM Account
            WHERE Name = 'My Account new'
        ];
        System.assertEquals(1, accountsToCompare.size(), 'Solo deberia haber insertado una cuenta.');
    }
}