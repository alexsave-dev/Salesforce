global class MyAccountManagerRequestsIdOnlyMock implements HttpCalloutMock {   
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json;charset=UTF-8');
        response.setBody('"0017Q00000675XBQAY"');
        response.setStatusCode(200);
        return response;  
    }
}