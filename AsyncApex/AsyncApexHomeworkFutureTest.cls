@isTest
private class AsyncApexHomeworkFutureTest {
    
    @testSetup
    static void setup() {
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
                
        // Perform the test
        Test.startTest();
        AsyncApexHomeworkFuture.updateContacts();
        Test.stopTest();
        
        // Check the result
		System.assertEquals(50, [SELECT COUNT() FROM Contact WHERE Is_Synced__c = false AND Processed_By_Future__c = true]);   
        
    }

}