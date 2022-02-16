@isTest
public with sharing class ServicePokemonMock implements HttpCalloutMock {
    
    public HttpResponse respond (HttpRequest request) {

        HttpResponse response = new HttpResponse();        
        response.setHeader('Content-Type', 'application/json');

        if (request.getEndpoint().contains('pikachu')) {
            response.setBody('{"name": "pikachu"}');
            response.setStatusCode(200);    
        } else {
            response.setStatusCode(404);
        }

        return response;
    }
}
