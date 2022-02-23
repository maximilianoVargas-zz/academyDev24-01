@isTest
public with sharing class PokemonServiceTest {
    @isTest static void PokemonServiceTest() {
        Test.setMock(HttpCalloutMock.class, new PokemonServiceHttpCalloutMock());

        Test.startTest();
        HttpResponse response = PokemonService.getDataPokemos('name');
        Test.stopTest();

        String contentType = response.getHeader('Content-Type');
        Integer statusCode = response.getStatusCode();
        String body = response.getBody();

        System.assertEquals('application/json', contentType);
        System.assertEquals(200, statusCode);
        System.assertEquals('{"respuesta":"ok"}', body);
    }
}