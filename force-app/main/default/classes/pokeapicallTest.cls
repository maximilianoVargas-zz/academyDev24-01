@isTest
public with sharing class pokeapicallTest {
    @isTest 
    static void testGetCallPokeApi() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('StaticPokemon');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');    
        Test.setMock(HttpCalloutMock.class, mock);        
        HttpResponse result = pokeapicall.getPokemonById(10);

          

        System.assertEquals(200,result.getStatusCode(), 'El código de respuesta de la API no es el 200');
        System.assertNotEquals(null,result, 'La Api no devolvió ningún vaor');

    }
}
