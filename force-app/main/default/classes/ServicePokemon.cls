public with sharing class ServicePokemon {
    
    public static Pokemon findPokemonByName(String name) {

        Http http = new Http();
        HttpRequest request = new HttpRequest();

        request.setMethod('GET');
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+name);
        request.setHeader('Contenty-Type', 'application/json');
        request.setHeader('Accept', 'application/json');

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            return Pokemon.parse(response.getBody());
        } else {
            System.debug('Error invoking service: ' +response.getStatusCode());
            return null;
        }

    }

}
