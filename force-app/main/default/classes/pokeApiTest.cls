@isTest
public with sharing class pokeApiTest {
    @isTest
    static  void testGetCallout() {

        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('pokemonResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
        HttpResponse result = pokeApi.makeGetCallout(1);
        Test.stopTest();

        System.assertNotEquals(null,result, 'The callout returned a null response.');
        System.assertEquals(200,result.getStatusCode(), 'The status code is not 200.'); 
        System.assertEquals('application/json;charset=UTF-8',
        result.getHeader('Content-Type'),
        'The content type value is not expected.');  
  
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(result.getBody());
            List<Object> pokemonForm = (List<Object>) results.get('forms');
        System.assertEquals(1, pokemonForm.size(), 'The array should only contain 1 items.');          
    }   
}
