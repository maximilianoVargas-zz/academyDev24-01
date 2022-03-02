@isTest
public with sharing class PokemonServiceTest {
    public PokemonServiceTest() {

    }

    @isTest
    static void whenConsumingRestApiByName(){
        /*
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetPokemonResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        //Test.setMock(PokemonService.class, mock);

        //PokemonService servicio = new PokemonService();
        
        PokemonData pokemon = PokemonService.getPokemonByName('ditto');        
        */
        // Verify mock response is not null
        //System.assertNotEquals(null,result, 'The callout returned a null response.');
        // Verify status code
        //System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.');
        // Verify content type   
        //System.assertEquals('application/json;charset=UTF-8',
          //result.getHeader('Content-Type'),
          //'The content type value is not expected.');  
        
        /*
        System.assertNotEquals(null, pokemon,'The api callout returned a null object');
        System.assertEquals('ditto', pokemon.name,'The api callout not returned pokemon by name');
        */
    }    
}
