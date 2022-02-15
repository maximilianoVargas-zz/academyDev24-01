@isTest
public with sharing class PokemonWork1Test {
    @isTest
    static void shouldReturnPokemonName(){
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('PokemonResponse');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');

        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
        PokemonConverter result=PokemonWork1.findPokemonById(100);
        Test.stopTest();
        String pokemonName=result.name;

        System.assertEquals('voltorb', pokemonName,'pokemon name dos not match with expected');

        
    }
}