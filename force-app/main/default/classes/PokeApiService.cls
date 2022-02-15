public with sharing class PokeApiService {
    
    public static HttpResponse getPokemonByName(String name) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + name);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        return response;
    }
}