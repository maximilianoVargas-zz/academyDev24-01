public with sharing class PokemonService {
    public static HttpResponse getDataPokemos(String name) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + 'ditto');
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/text;charset=UTF-8');
        HttpResponse response = http.send(request);
        
        return response;
    }
}