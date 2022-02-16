public with sharing class AccountManage {
    
    public static Id createAccount(String accName, Integer accEmployees, String accDocType, String accDocNum) {
        Account acc = new Account(Name = accName, NumberOfEmployees = accEmployees, Identification_type__c = accDocType, Document_number__c = accDocNum);
        insert acc;
        return acc.Id;
    }

    public static Boolean updateAccount(String accName, Integer accEmployees, String accDocType, String accDocNumber) {
        Account acc = consultAccount(accDocType, accDocNumber);
        if(acc != null) {
            acc.Name = accName;
            acc.NumberOfEmployees = accEmployees;
            Database.SaveResult res = Database.update(acc);
            return res.isSuccess();
        }
        return false;
    }

    public static Boolean deleteAccount(String accDocType, String accDocNumber) {
        List<Account> acc = [SELECT Id FROM Account WHERE Identification_type__c = :accDocType AND Document_number__c = :accDocNumber LIMIT 1];
        Database.DeleteResult res = Database.delete(acc.get(0).Id);
        return res.isSuccess();
    }

    public static Account consultAccount(String accDocType, String accDocNumber) {
        List<Account> acc = [SELECT Id, Name FROM Account WHERE Identification_type__c = :accDocType AND Document_number__c = :accDocNumber LIMIT 1];
        if(!acc.isEmpty()) {
            return acc.get(0);
        } else {
            return null;
        }
    }

    public static void createOpportunity(List<Account> accounts) {
        List<Opportunity> toCreate = new List<Opportunity>();
        for(Account anAccount : accounts){
            if(anAccount.Create_Opportunity__c) {
                Opportunity op = new Opportunity(Name = 'Opportunity' + anAccount.Name + System.today(), StageName = 'Prospection', CloseDate = system.today() + 30, AccountId = anAccount.Id);
                toCreate.add(op);
            }
        }
        insert toCreate;
    }

}