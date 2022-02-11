@isTest
private class PokeApiServiceTest {
    @isTest static void shouldReturnACorrectPokemonFromTheApi(){
        Test.setMock(HttpCalloutMock.class, new PokeApiServiceMock());
        Integer idObtained = PokeApiService.getFromPokeApi('ditto').id;
        System.assertEquals(132, idObtained, 'Something was unexpected');
    }
}
