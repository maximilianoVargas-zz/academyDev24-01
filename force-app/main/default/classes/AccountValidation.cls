public with sharing class AccountValidation {
    public static boolean validateAccount(List<Account> accounts){

        Map<String, Account> m = new Map<String, Account>();

        List<String> dupes = new List<String>();
        
        Boolean dupe = false;
        
        for (Account acc : [SELECT Document_number__c
                FROM Account
                WHERE Active__c ='yes']){
                    m.put(acc.Document_number__c,acc);
                }

        for(Account a : accounts){
            if(m.containsKey(a.Document_number__c)){
                dupes.add(a.Document_number__c);
            }
        }

        if(dupes.size()>0){
            dupe = true;
        }
        
        return dupe;
    }

}