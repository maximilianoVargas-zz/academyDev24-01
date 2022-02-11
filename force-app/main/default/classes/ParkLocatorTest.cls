@isTest
private class ParkLocatorTest {
    @isTest static void testCallout() {              
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
		String country = 'United States';
        List<String> result = ParkLocator.country(country);
        List<String> parks = new List<String>();
        parks.add('Yosemite');
        parks.add('Yellowstone');
        parks.add('Another Park');
        System.assertEquals(parks, result); 
    }
}