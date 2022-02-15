public with sharing class PokemonService {
    public static HttpResponse GetPokemonFromApi(String pokemonName) {
        Http http = new Http();

        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + pokemonName);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');

        HttpResponse response = http.send(request);

        return response;
    }
}