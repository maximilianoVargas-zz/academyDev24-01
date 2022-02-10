public with sharing class PokemonWork1 {
    public static PokemonConverter findPokemonById(Integer pokemonId){
        String pokemonApi='https://pokeapi.co/api/v2/pokemon/';
        Http http=new Http();
        HttpRequest request=new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint(pokemonApi+pokemonId);

        HttpResponse response=http.send(request);
        PokemonConverter pokemon=null;

        if (response.getStatusCode()==200) {
            pokemon=PokemonConverter.parse(response.getBody());
        }

        return pokemon;
    }

    /*
    First exercise:

Problem: We need to create a new service class, in this class we need to creates a function to consume a Rest Api.
	this function receive a String and use this for get a data from the API and return the data of response


api: https://pokeapi.co/


    */

}