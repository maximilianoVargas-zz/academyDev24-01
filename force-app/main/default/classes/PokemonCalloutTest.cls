@isTest
private class PokemonCalloutTest {
    @isTest static  void testGetCallout() {
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetPokemonResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        HttpResponse result = PokemonCallout.makeGetCallout(25);
        // Verify mock response is not null
        System.assertNotEquals(null,result, 'The callout returned a null response.');
        // Verify status code
        System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.');
        // Verify content type   
        System.assertEquals('application/json;charset=UTF-8',
          result.getHeader('Content-Type'),
          'The content type value is not expected.');  
        // Verify the array contains 3 items     
        Map<String, Object> results = (Map<String, Object>) 
            JSON.deserializeUntyped(result.getBody());
            List<Object> pokemons = (List<Object>) results.get('forms');
            String aPokeName;
            
            for(Object pokemon: pokemons) {
                Map<String,Object> tempMap = (Map<String,Object>)pokemon;
                System.debug('Name: '+ tempMap.get('name'));
                aPokeName = String.valueOf(tempMap.get('name'));
            }
        System.assertEquals('pikachu', aPokeName, 'Pokemon name does not match');          
    }   
}