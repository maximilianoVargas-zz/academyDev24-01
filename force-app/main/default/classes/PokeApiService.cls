public class PokeApiService {

    public static HttpResponse getPokemonByName(String pokemonName) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+ pokemonName);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
       
        /*AnimalResult result = (AnimalResult) JSON.deserialize(response.getBody(), AnimalResult.class);
        System.debug('Received the following animal:' + result.animal.name);
        return result.animal.name;*/

        return response;
    
    }
}