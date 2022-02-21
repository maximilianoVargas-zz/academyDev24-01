public with sharing class pokeapicall {
    public static HttpResponse getPokemonById(Integer id){
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/' + id);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        return response;
    }
}
