public class pokeApi {
    public static HttpResponse makeGetCallout(Integer pokemonNumber) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + pokemonNumber);
        request.setMethod('GET');
        
        HttpResponse response = http.send(request);

        // if(response.getStatusCode() == 200) {
        //     Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        //     List<Object> pokemonForm = (List<Object>) results.get('forms');
        // }
        return response;
    }       
}