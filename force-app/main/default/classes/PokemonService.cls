public with sharing class PokemonService {
    private static string urlApiBase = 'https://pokeapi.co/api/v2/pokemon';    

    public static PokemonData getPokemonByName(string nombre){
        return calloutApi(urlApiBase + '/' + nombre);
    }

    public static PokemonData getPokemonById(Integer id){        
        return calloutApi(urlApiBase + '/' + id);
    }

    private static PokemonData calloutApi(string url){
        Http httpClient = new Http();
        HttpRequest request = new HttpRequest();
        PokemonData data = null;
        request.setEndpoint(url);
        request.setMethod('GET');
        HttpResponse response = httpClient.send(request);
        if(response.getStatusCode() == 200){
            data = (PokemonData) JSON.deserialize(response.getBody(), PokemonData.class);
        }
        return data;
    }
}