@IsTest
public with sharing class AccountTriggerTest {

    @TestSetup
    static void makeData(){
        Account anAccount = new Account(Name='TestAccount',Identification_type__c='cc',Document_number__c=123);
        insert anAccount;
    }

    @IsTest
    public static void whenInsertAnAlreadyExistAccountShowError(){
        Account anAccount = new Account(Name='TestAccount',Identification_type__c='cc',Document_number__c=123);
        String errorMessage;
        Test.startTest();
        try{
            Database.SaveResult result = database.insert(anAccount);
        }catch(DmlException anException){
            errorMessage = anException.getMessage();
        }
        Test.stopTest();

        System.assert(errorMessage.contains('The account already exist.'),'The account insertion was valid.');
    }

    @IsTest
    public static void whenInsertANonExistingAccountTheProcessIsCorrect(){
        Account anAccount = new Account(Name='TestAccount',Identification_type__c='cc',Document_number__c=123456);
        String errorMessage;
        Database.SaveResult result;
        Test.startTest();
        try{
            result = database.insert(anAccount);
        }catch(DmlException anException){
            errorMessage = anException.getMessage();
        }
        Test.stopTest();

        System.assert(result.isSuccess(),'The account insertion was not valid.');
    }


}