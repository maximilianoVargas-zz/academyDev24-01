/* First exercise:

Problem: We need to create a new service class, in this class we need to creates a function to 
consume a Rest Api.
this function receive a String and use this for get a data from the API and return the data
of response

api: https://pokeapi.co/
 */
public with sharing class ConsumingRestApi {
    public static HttpResponse getPokemonNameByString(String nombre) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(' https://pokeapi.co/api/v2/pokemon/'+nombre);
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if(response.getStatusCode() == 200) {
            return response;
        }else{
            return response;
        }
       
    }
}
