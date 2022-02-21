@isTest
private class TestRestrictContactByName {
    @isTest static void TestRestrictContactByNameInsert() {

        Contact cont = new Contact(LastName='INVALIDNAME');

        Test.startTest();
        Database.SaveResult result = Database.insert(cont, false);
        Test.stopTest();

        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "'+cont.LastName+'" is not allowed for DML',
                             result.getErrors()[0].getMessage());
    }
}