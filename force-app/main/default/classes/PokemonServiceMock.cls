@isTest
public with sharing class PokemonServiceMock implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"id":25,"name":"pikachu","order":35,"height":4}');
        response.setStatusCode(200);
        return response; 
    }
}