@isTest
private class AsyncApexHomeworkBatchTest {
    @testSetup
    private static void setup() {
        // 10 Accounts with Updated_By_Contact__c = false
        // and two contacts. One has Is_Synced__c = true
        // and the second one has Is_Synced__c = false
        // Contacts have empty MailingAddress
        
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();
        for (Integer i=0; i<10; i++) {
            Account newAccount = new Account(Name='Test account ' + i,
                    BillingStreet = 'Street',
                    BillingCity = 'City',
                    BillingState = 'State',
                    BillingPostalCode = '142001',	
                    BillingCountry = 'RU',
                    Updated_By_Contact__c = false);                         
            accounts.add(newAccount);
        }    
        insert accounts;

        for (Integer i=0; i<10; i++) {
            Contact syncedContact = new Contact(LastName = 'LastName1', Is_Synced__c = true, AccountId = accounts.get(i).id);
            Contact unsyncedContact = new Contact(LastName = 'LastName2', Is_Synced__c = false, AccountId = accounts.get(i).id);
            contacts.add(syncedContact);
            contacts.add(unsyncedContact);
        } 
        insert contacts;
    }
    
    @isTest 
    private static void test() {
        Test.startTest();
        AsyncApexHomeworkBatch asyncApexHomeworkBatch = new AsyncApexHomeworkBatch();
        Id batchId = Database.executeBatch(asyncApexHomeworkBatch);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        System.assertEquals(10, [SELECT COUNT() FROM Account WHERE Updated_By_Contact__c = true]);
        System.assertEquals(20, [SELECT COUNT() FROM Contact WHERE Is_Synced__c = true]);
        System.assertEquals(10, [SELECT COUNT() FROM Contact 
                                 WHERE MailingStreet = 'Street'
                                AND MailingCity = 'City'
                                AND MailingState = 'State'
                                AND MailingPostalCode = '142001'	
                                AND MailingCountry = 'RU']);
    }
}