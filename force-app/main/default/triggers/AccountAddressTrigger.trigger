trigger AccountAddressTrigger on Account (before insert, before update) {
    
    for(Account a : Trigger.New) {

        if (a.Match_Billing_Address__c == true) {
           a.ShippingPostalCode = a.BillingPostalCode;
        }           
    }

 }