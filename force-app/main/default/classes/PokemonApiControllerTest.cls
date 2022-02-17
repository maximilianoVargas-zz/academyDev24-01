@isTest
public with sharing class PokemonApiControllerTest {

    @isTest static void VerifyIfTheResponseContainThePokemonSearched(){

        Test.startTest();
        EntityPokemonApi pokemonResult=PokemonApiController.PokemonMock('ditto');
        Test.stopTest();

        System.assertEquals('ditto', pokemonResult.name,'The Body no match');
         
    }

    @isTest static void VerifyIfTheResponseIsNullWhenSearchedApokemon(){

        Test.startTest();
        EntityPokemonApi pokemonResult=PokemonApiController.PokemonMock('');
        Test.stopTest();

        System.assertEquals(null, pokemonResult,'The Body Is Not Empty');
    }   
}
