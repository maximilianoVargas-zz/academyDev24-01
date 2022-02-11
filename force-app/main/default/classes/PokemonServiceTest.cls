@IsTest
public with sharing class PokemonServiceTest {
    @IsTest 
    public static void whenConsultAPokemonReturnsTheSpecified(){
        
        Test.setMock(HttpCalloutMock.class, new PokemonServiceMock()); 
        
        PokemonService service = new PokemonService();
        HttpResponse response = service.getPokemonByName('pikachu');
        
        String expectedValue = '{"id":25,"name":"pikachu","order":35,"height":4}';
        
        System.assertEquals(response.getStatusCode(), 200, 'The request was not succesfull');
        System.assertEquals(response.getBody(),expectedValue, 'The expected body was wrong');
    }
}