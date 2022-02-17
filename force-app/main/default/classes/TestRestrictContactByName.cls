@isTest
public class TestRestrictContactByName {
	@isTest
    static void createBadContact(){
        Contact c = new Contact(FirstName='Pedro',LastName='INVALIDNAME');
        
        Test.startTest();
        DataBase.SaveResult result = Database.insert(c, false);
        Test.stopTest();
        
        System.assert(!result.isSuccess());
    }
}