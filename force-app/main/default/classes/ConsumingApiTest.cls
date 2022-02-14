@isTest
public with sharing class ConsumingApiTest {
    @isTest static void retrieveAJsonResponseWhenAskForAPokemon() {

        Test.setMock(HttpCalloutMock.class, new ConsumingApiMock());
        // Call method to test
        HttpResponse result = ConsumingRestApi.getPokemonNameByString('pikachu');
        // Verify mock response is not null
        System.assertNotEquals(null,result, 'The callout returned a null response.');

        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(result.getBody());
           
        Map<String, Object> pokemonData = (Map<String, Object>) results.get('pokemon');
        
        System.assertEquals('pikachu', (String) pokemonData.get('name'), 'The name should be Pikachu');          
    }
}