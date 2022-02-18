@isTest
global class ConsumingApiMock implements HttpCalloutMock {
    // Implement this interface method
    global HTTPResponse respond(HTTPRequest request) {
        // Create a fake response
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"pokemon":{"id":2,"name":"pikachu","eats":"berries, campers, adam seligman","says":"yum yum"}}');
        response.setStatusCode(200);
        return response; 
    }
}