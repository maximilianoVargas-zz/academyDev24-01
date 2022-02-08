trigger AccountAddressTrigger on Account (before insert, before update) {
    List<Account> accounts = trigger.new;
    for(Account anAccount : accounts){
        //AccountValidation.validateAccount(anAccount);
        if(anAccount.Match_Billing_Address__c){
            anAccount.ShippingPostalCode = anAccount.BillingPostalCode;
        }
    }
}