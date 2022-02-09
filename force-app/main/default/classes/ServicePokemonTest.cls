@isTest
public with sharing class ServicePokemonTest {
    
    @isTest static void shouldFindPokemonByName() {

        Test.setMock(HttpCalloutMock.class, new ServicePokemonMock());
        Pokemon pokemon = ServicePokemon.findPokemonByName('pikachu');
        
        System.assert(pokemon != null, 'Pokemon is null');
        System.assertEquals('pikachu', pokemon.name, 'Pokemon name should be pikachu');

    }

    @isTest static void ifPokemonDoesntExistShouldGetNull() {

        Test.setMock(HttpCalloutMock.class, new ServicePokemonMock());
        Pokemon pokemon = ServicePokemon.findPokemonByName('fakepokemon');

        System.assert(pokemon == null, 'Pokemon should be null');

    }
}
