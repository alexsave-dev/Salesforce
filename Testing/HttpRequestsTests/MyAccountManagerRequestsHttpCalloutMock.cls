global class MyAccountManagerRequestsHttpCalloutMock implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json;charset=UTF-8');
        response.setBody('{"id": "0017Q00000675XBQAY", "name" : "Account Name"}');
        response.setStatusCode(200);
        return response;  
    }

}