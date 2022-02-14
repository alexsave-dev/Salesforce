public class AsyncApexHomeworkFuture {
    @future
    public static void updateContacts() {
	
        List<Account> accounts = [SELECT BillingAddress, 
                                  (SELECT Is_Synced__c, Processed_By_Future__c, Name from Contacts) 
                                  FROM Account LIMIT 150];
        List<Contact> contacts = new List<Contact>();
								
        for (Account account : accounts) {
            if (account.BillingAddress != null) {
                for (Contact contact : account.Contacts) {
                    contact.Is_Synced__c = false;
                    contact.Processed_By_Future__c = true;
                    contacts.add(contact);
                } 
            }
        }
		update contacts;
    }
}