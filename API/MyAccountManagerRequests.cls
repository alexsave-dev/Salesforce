public class MyAccountManagerRequests {
	private static final String authorizationHeader = 'Bearer 00D7Q000004RRVT!ARgAQOkpPj5z2KB6ocrOPA2WxBqBtov2DxyLb.A.z9M1koQWipaoz9QMzIDCuOETvaqZueG2V0WG6M9qKR.8SonTkMEuTUX1';//add here received accestoken after bearer
	private static final String endpoint = 'https://creative-moose-e2txsh-dev-ed.my.salesforce.com/services/apexrest/my/Accounts/'; 
    private static Http h;
    private static HttpRequest req;
    
    public static HttpResponse makeGetCallout(Id accountId) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', authorizationHeader);        
        req.setMethod('GET');
        req.setEndpoint(endpoint + accountId);        
        HttpResponse res = h.send(req);      
        System.debug('Body: ' + res.getBody());     
        return res;
    }
    
    public static HttpResponse makePostCallout(String accountName) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', authorizationHeader);        
        req.setMethod('POST');
        req.setEndpoint(endpoint);        
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setBody('{"name": "' + accountName + '"}');
        HttpResponse res = h.send(req);      
        System.debug('Body: ' + res.getBody());     
        return res;
    }

    public static HttpResponse makeDeleteCallout(Id accountId) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', authorizationHeader);        
        req.setMethod('DELETE');
        req.setEndpoint(endpoint + accountId);        
        HttpResponse res = h.send(req);      
        System.debug('Body: ' + res.getBody());     
        return res;
    }
    
    public static HttpResponse makePutCallout(Id accountId, String accountName) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', authorizationHeader);        
        req.setMethod('PUT');
        req.setEndpoint(endpoint);        
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setBody('{"id": "' + accountId + '","name": "' + accountName + '"}');        
        HttpResponse res = h.send(req);      
        System.debug('Body: ' + res.getBody());     
        return res;
    }
    
    public static HttpResponse makePutCallout(String accountName) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', authorizationHeader);        
        req.setMethod('PUT');
        req.setEndpoint(endpoint);        
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setBody('{"name": "' + accountName + '"}');        
        HttpResponse res = h.send(req);      
        System.debug('Body: ' + res.getBody());     
        return res;
    }

    public static HttpResponse makePatchCallout(Id accountId, String accountName) {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setHeader('Authorization', authorizationHeader);        
        req.setMethod('PATCH');
        req.setEndpoint(endpoint + accountId);        
        req.setHeader('Content-Type', 'application/json;charset=UTF-8');
        req.setBody('{"name": "' + accountName + '"}');        
        HttpResponse res = h.send(req);      
        System.debug('Body: ' + res.getBody());     
        return res;
    }
    
}