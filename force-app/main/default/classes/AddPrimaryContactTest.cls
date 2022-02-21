@isTest
public class AddPrimaryContactTest {
	@isTest
    private static void testQueuableClass(){
        //Load test data
        List<Account> accounts = new List<Account>();
        for (Integer i=0; i<250; i++){
            Account acc = new Account(Name='Test Account', BillingState = 'CA');
			accounts.add(acc);
        }
        insert accounts;
        
        Contact contact = new Contact(Firstname='Simon', LastName='Cowell');
        insert contact;
        
        //Perform test
        Test.startTest();
        Id jobId = System.enqueueJob(new AddPrimaryContact(contact,'CA'));
        Test.stopTest();
        
        //Check the results
        List<Contact> contacts = [SELECT Id FROM Contact WHERE Contact.Account.BillingState = 'CA'];
        System.assertEquals(200, contacts.size(), 'ERROR: Incorrect number of contact records found');
    }
}