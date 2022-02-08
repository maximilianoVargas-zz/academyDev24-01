@isTest
public with sharing class TestRestrictContactByName {
    @isTest static void TestInsertFail(){
        Contact aContact = new Contact(FirstName='Maria', LastName='INVALIDNAME');

        Test.startTest();
        Database.SaveResult result = Database.insert(aContact, false);
        Test.stopTest();

        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size()>0);
        System.assertEquals('The Last Name "'+aContact.LastName+'" is not allowed for DML', result.getErrors()[0].getMessage());
    }

    @isTest static void TestInsertSuccess(){
        Contact aContact = new Contact(FirstName='Maria', LastName='Rodriguez');

        Test.startTest();
        Database.SaveResult result = Database.insert(aContact, false);
        Test.stopTest();

        System.assert(result.isSuccess());
    }
}