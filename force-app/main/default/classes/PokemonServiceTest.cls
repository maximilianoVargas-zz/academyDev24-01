@isTest
public with sharing class PokemonServiceTest {

    @isTest
    static void PokemonServiceTestUsingMock() {

        Test.setMock(HttpCalloutMock.class, new PokemonServiceMock());

        Test.startTest();
        HttpResponse response = PokemonService.GetPokemonFromApi('ditto');
        Test.stopTest();
        String actual = response.getBody();
        String expected = '{"abilities":[{"ability":{"name":"limber","url":"https://pokeapi.co/api/v2/ability/7/"},"is_hidden":false,"slot":1},{"ability":{"name":"imposter","url":"https://pokeapi.co/api/v2/ability/150/"},"is_hidden":true,"slot":3}]}';

        System.assertEquals(expected, actual, 'The response didnt match');
    }
}
