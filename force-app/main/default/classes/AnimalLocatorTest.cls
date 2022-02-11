@isTest
private class AnimalLocatorTest {
    @isTest 
    static void getAnimalByIdTest() {
    Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
    String response = AnimalLocator.getAnimalNameById(1);
       
    System.assertEquals('chicken', response);
}
}