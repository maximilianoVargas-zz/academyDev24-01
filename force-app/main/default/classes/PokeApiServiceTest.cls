@isTest
public with sharing class PokeApiServiceTest {
    
    @isTest
    public static void testGetPokemon() {
        // Create the mock response based on a static resource
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('PokeApiGetDitto');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);

        // Call method to test
        Test.startTest();
        HttpResponse result = PokeApiService.getPokemonByName('ditto');
        Test.stopTest();

        // Verify mock response is not null
        System.assertNotEquals(null, result, 'The callout returned a null response.');
        // Verify status code
        System.assertEquals(200, result.getStatusCode(), 'The status code is not 200.');
        // Verify content type   
        System.assertEquals(
            'application/json;charset=UTF-8',
            result.getHeader('Content-Type'),
            'The content type value is not expected.'
        ); 

        // Verify ditto's pokemon number
        JSONParser parser = JSON.createParser(result.getBody());
        Integer pokemonNumber;
        while (parser.nextToken() != null) {
            if (parser.getCurrentToken() == JSONToken.FIELD_NAME && parser.getText() == 'id') {
                // Get the value.
                parser.nextToken();
                pokemonNumber = (Integer)parser.readValueAs(Integer.class);
                break;
            }
        }
        System.assertEquals(132, pokemonNumber, 'Ditto`s pokemon number must be 132');
    }
}