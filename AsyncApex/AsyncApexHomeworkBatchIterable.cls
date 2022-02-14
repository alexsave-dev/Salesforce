public class AsyncApexHomeworkBatchIterable implements Database.Batchable<sObject>{
    
    public Iterable<sObject> start(Database.BatchableContext bc) {
        List<Contact> contacts = [SELECT Id, MailingAddress, Is_Synced__c, AccountId 
            	FROM Contact WHERE Is_Synced__c = false]; 
        return contacts;
    }
    
    public void execute(Database.BatchableContext bc, List<Contact> contacts){
		Set<Id> accountIds = new Set<Id>();
        for (Contact contact : contacts) {
            accountIds.add(contact.AccountId);
        }
        
        List<Account> accounts = [SELECT Id, BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry 
                                  FROM Account WHERE Id in :accountIds];
        for (Account account : accounts) {
            account.Updated_By_Contact__c = true;
        }
        
        for (Contact contact : contacts) {
            contact.Is_Synced__c = true;
            for (Account account : accounts) {
                if (contact.AccountId == account.Id) {
                    contact.MailingStreet = account.BillingStreet;
                    contact.MailingCity = account.BillingCity;
                    contact.MailingState = account.BillingState;
                    contact.MailingPostalCode = account.BillingPostalCode;	
                    contact.MailingCountry = account.BillingCountry;
                    break;
                }
            }
        }
		update accounts;        
        update contacts;
    }
    
    public void finish(Database.BatchableContext bc){
        System.debug('Batch is over');
    }

}