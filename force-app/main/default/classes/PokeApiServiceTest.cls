@isTest
private class PokeApiServiceTest {
    @isTest static void shouldReturnACorrectPokemonFromTheApi(){
        Test.setMock(HttpCalloutMock.class, new PokeApiServiceMock());

        Test.startTest();
        Integer idObtained = PokeApiService.getFromPokeApi('ditto').id;
        Test.stopTest();
        
        System.assertEquals(132, idObtained, 'Something was unexpected');
    }
}