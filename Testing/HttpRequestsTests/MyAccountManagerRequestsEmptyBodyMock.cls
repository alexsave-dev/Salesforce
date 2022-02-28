global class MyAccountManagerRequestsEmptyBodyMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest request) {
        HttpResponse response = new HttpResponse();
        response.setBody('');
        response.setStatusCode(200);
        return response;  
    }
}