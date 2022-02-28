@isTest
private class MyAccountManagerRequestsTest {
    @isTest 
    static void makeGetCalloutTest() {
        Test.setMock(HttpCalloutMock.class, new MyAccountManagerRequestsHttpCalloutMock()); 
        HttpResponse response = MyAccountManagerRequests.makeGetCallout('0017Q00000675XBQAY');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '{"id": "0017Q00000675XBQAY", "name" : "Account Name"}';
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }

    @isTest 
    static void makePostCalloutTest() {
        Test.setMock(HttpCalloutMock.class, new MyAccountManagerRequestsIdOnlyMock()); 
        HttpResponse response = MyAccountManagerRequests.makePostCallout('Account Name Post');
        String contentType = response.getHeader('Content-Type');
        System.assert(contentType == 'application/json;charset=UTF-8');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '"0017Q00000675XBQAY"';
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }
    
    @isTest 
    static void makeDeleteCalloutTest() {
        Test.setMock(HttpCalloutMock.class, new MyAccountManagerRequestsEmptyBodyMock()); 
        HttpResponse response = MyAccountManagerRequests.makeDeleteCallout('0017Q00000675XBQAY');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '';
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }
    
    @isTest 
    static void makePutCalloutWithIdTest() {
        Test.setMock(HttpCalloutMock.class, new MyAccountManagerRequestsIdOnlyMock()); 
        HttpResponse response = MyAccountManagerRequests.makePutCallout('0017Q00000675XBQAY', 'Account Name Put');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '"0017Q00000675XBQAY"';
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }

    @isTest 
    static void makePutCalloutWithoutIdTest() {
        Test.setMock(HttpCalloutMock.class, new MyAccountManagerRequestsIdOnlyMock()); 
        HttpResponse response = MyAccountManagerRequests.makePutCallout('Account Name Put 1');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '"0017Q00000675XBQAY"';
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }

    @isTest 
    static void makePatchCalloutWithoutIdTest() {
        Test.setMock(HttpCalloutMock.class, new MyAccountManagerRequestsIdOnlyMock()); 
        HttpResponse response = MyAccountManagerRequests.makePatchCallout('0017Q00000675XBQAY', 'Account Name Patch');
        String actualValue = response.getBody();
        System.debug(response.getBody());
        String expectedValue = '"0017Q00000675XBQAY"';
        System.assertEquals(expectedValue, actualValue);
        System.assertEquals(200, response.getStatusCode());
    }
}