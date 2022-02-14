public class AsyncApexHomeworkQueueable implements Queueable {
        
    public void execute(QueueableContext context) {
        List<Contact> contacts = new List<Contact>();
								
        for (Account account : [SELECT BillingAddress, 
                                  (SELECT Is_Synced__c, Processed_By_Queue__c, Name from Contacts) 
                                  FROM Account ]) {
            if (account.BillingAddress != null) {
                for (Contact contact : account.Contacts) {
                    contact.Is_Synced__c = false;
                    contact.Processed_By_Queue__c = true;
                    contacts.add(contact);
                } 
            }
        }
		update contacts;
    }
}