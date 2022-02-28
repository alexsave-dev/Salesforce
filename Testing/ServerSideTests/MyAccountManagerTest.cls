@isTest
global with sharing class MyAccountManagerTest {
    
    @testSetup
    private static void testSetup() {
        Account account = new Account(Name = 'MyAccountManager Account');
        insert account;
    }
    
    @isTest
    private static void getAccountByIdTest() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Accounts/'
            + account.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;
        Test.startTest();
        Account thisAccount = MyAccountManager.getAccountById();
        Test.stopTest();
        System.assert(thisAccount != null);
        System.assertEquals('MyAccountManager Account', thisAccount.Name);
    }
    
    @isTest
    private static void createAccountTest() {
        Test.startTest();
        Id thisAccountId = MyAccountManager.createAccount('MyAccountManager Account Create');
        Test.stopTest();
        System.assert(thisAccountId != null);
        Account thisAccount = [SELECT Id, Name FROM Account WHERE Id=:thisAccountId LIMIT 1];
        System.assert(thisAccount != null);
        System.assertEquals('MyAccountManager Account Create', thisAccount.Name);
    }
    
    @isTest 
    private static void deleteAccountTest() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Accounts/'
            + account.Id;
        request.httpMethod = 'DELETE';
        RestContext.request = request;
        Test.startTest();
        MyAccountManager.deleteAccount();
        Test.stopTest();
        List<Account> accounts = [SELECT Id FROM Account WHERE Id=:account.Id];
        System.assert(accounts.size() == 0);
    }
    
    @isTest 
    private static void upsertAccountTest() {
        // 1. Insert new record
        Test.startTest();
        Id account1Id = MyAccountManager.upsertAccount('MyAccountManager Account Upsert', null);
        // Verify new record was created
        System.assert(account1Id != null);
        Account account1 = [SELECT Id, Name FROM Account WHERE Id = :account1Id];
        System.assert(account1 != null);
        System.assertEquals(account1.Name, 'MyAccountManager Account Upsert');
        // 2. Update status of existing record to Working
        Id account2Id = MyAccountManager.upsertAccount('MyAccountManager Account Upsert 1', account1Id);
        Test.stopTest();
        // Verify record was updated
        System.assertEquals(account1Id, account2Id);
        Account account2 = [SELECT Id, Name FROM Account WHERE Id = :account2Id];
        System.assert(account2 != null);
        System.assertEquals('MyAccountManager Account Upsert 1', account2.Name);
    }  
    
    @isTest 
    private static void updateAccountFieldsTest() {
        Account account = [SELECT Id FROM Account LIMIT 1];
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.my.salesforce.com/services/apexrest/Accounts/'
            + account.Id;
        request.httpMethod = 'PATCH';
        request.addHeader('Content-Type', 'application/json');
        request.requestBody = Blob.valueOf('{"name": "MyAccountManager Account Patch"}');
        RestContext.request = request;
        Test.startTest();
        Id thisAccountId = MyAccountManager.updateAccountFields();
        Test.stopTest();
        // Verify record was updated
        System.assert(thisAccountId != null);
        Account thisAccount = [SELECT Id, Name FROM Account WHERE Id = :thisAccountId];
        System.assert(thisAccount != null);
        System.assertEquals('MyAccountManager Account Patch', thisAccount.Name);
    }         
}