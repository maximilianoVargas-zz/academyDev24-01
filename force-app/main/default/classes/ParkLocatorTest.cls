@isTest
public class ParkLocatorTest {
	@isTest static void ParkServiceMock() {              
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        String[] result = ParkLocator.country('Germany');
        // Verify that a fake result is returned
        List<String> parks = new List<String>();
        parks.add('park1');
        parks.add('park2');
        System.assertEquals(parks, result); 
    }
}