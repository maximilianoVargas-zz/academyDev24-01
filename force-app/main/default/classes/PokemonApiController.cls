public with sharing class PokemonApiController {

    public static EntityPokemonApi Pokemon(String CharactersName) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+CharactersName);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        EntityPokemonApi pokemon;

        if(response.getStatusCode() == 200) {
            pokemon=EntityPokemonApi.parse(response.getBody());
            System.debug('Respuesta del body:'+response.getBody());
        }    
           
        else
            pokemon=null;
            
        return pokemon;
    }


    public static EntityPokemonApi PokemonMock(String CharactersName) {
        
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        string body=EntityPokemonApi.JsonPokemon();
        EntityPokemonApi pokemon;

        if(CharactersName =='ditto'){
            pokemon=EntityPokemonApi.parse(body);
        }
        else{
            pokemon=null;
        }
        
        return pokemon;
    }
}




