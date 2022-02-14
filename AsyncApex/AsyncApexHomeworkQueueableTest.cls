@isTest
private class AsyncApexHomeworkQueueableTest {
    
    @testSetup
    private static void setup() {
        List<Account> accounts = new List<Account>();
        List<Contact> contacts = new List<Contact>();
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account Billing Address ' + i,
                BillingState = 'NY'
            ));
        }
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account No Billing Address ' + i
            ));
        }
        insert accounts;
        for (Integer i = 0; i < 100; i++) {
            contacts.add(new Contact(
                LastName='Test Contact',
                AccountId = accounts.get(i).id
            ));
        }        
        insert contacts;
    }
    
    
    @isTest
    private static void updateContactsTest() {
                
        AsyncApexHomeworkQueueable updater = new AsyncApexHomeworkQueueable();
        // startTest/stopTest block to force async processes to run
        Test.startTest();
        System.enqueueJob(updater);
        Test.stopTest();
        
        // Check the result
		System.assertEquals(50, [SELECT COUNT() FROM Contact WHERE Is_Synced__c = false AND Processed_By_Queue__c = true]);   
        
    }
}