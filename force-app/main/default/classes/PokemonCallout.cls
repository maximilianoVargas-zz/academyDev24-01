public class PokemonCallout {
    public static HttpResponse makeGetCallout(Integer id) {
        Integer pokeid = id;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + pokeid);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        String aPokeName = '';
        if(response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());

            List<Object> pokemons = (List<Object>) results.get('forms');
            
            System.debug('Received the following pokemon:');
            for(Object pokemon: pokemons) {
                Map<String,Object> tempMap = (Map<String,Object>)pokemon;
                System.debug('Name: '+ tempMap.get('name'));
                aPokeName = String.valueOf(tempMap.get('name'));
            }

        }
        return response;
    }      
}