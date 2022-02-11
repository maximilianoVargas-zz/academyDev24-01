public with sharing class PokemonService {
    public HttpResponse getPokemonByName(String name){
        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+name);
        request.setMethod('GET');
        request.setHeader('Content-Type', 'appication/json');
        request.setHeader('Accept', 'application/json');

        HttpResponse response = http.send(request);
        system.debug(response.getBody());
        return response;
    }

}