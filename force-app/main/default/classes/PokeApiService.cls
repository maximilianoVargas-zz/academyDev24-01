public with sharing class PokeApiService {
    public static Pokemon getFromPokeApi(String requestedPokemon){
        //Make GET call
        Http http = new Http();
		HttpRequest request = new HttpRequest();
		request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + requestedPokemon);
		request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        HttpResponse response = http.send(request);
        //Get the response
        if(response.getStatusCode() == 200) {
            // Deserialize the JSON string into collections of primitive data types.
    		Pokemon parsedPokemon = Pokemon.parse(response.getBody());
    		
        	return parsedPokemon;
        }
        else{
            System.debug('The status code returned was not expected: ' +
                response.getStatusCode() + ' ' + response.getStatus());
            return null;
        }
    }
}
