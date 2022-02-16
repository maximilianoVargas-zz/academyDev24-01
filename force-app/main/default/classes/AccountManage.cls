public with sharing class AccountManage {

    public static Id createAccount(String name, Integer employees, String idType, String documentNumber) {

        Account anAccount = new Account(Name = name, 
        NumberOfEmployees = employees, 
        Identification_type__c = idType, 
        Document_number__c = documentNumber);

        insert anAccount;
        return anAccount.Id;
        
    }

    public static Boolean updateAccount(String name, Integer employees, String idType, String documentNumber) {

        Account anAccount = consultAccount(idType, documentNumber);        

        if (anAccount != null) {
            anAccount.Name = name;
            anAccount.NumberOfEmployees = employees;
            Database.SaveResult result = Database.update(anAccount);
            return result.isSuccess(); 
        }

        return false;
             
    }

    public static Boolean deleteAccount(String idType, String documentNumber) {

        Account anAccount = consultAccount(idType, documentNumber);

        if (anAccount != null) {
            Database.DeleteResult result = Database.delete(anAccount, false);
            return result.isSuccess();
        }

        return false;
    }
    
    public static Account consultAccount(String idType, String documentNumber) {
        try {
            return [Select Id, Name FROM Account 
                    WHERE Identification_type__c = :idType 
                    AND Document_number__c = :documentNumber
                    LIMIT 1];
        } catch (Exception e) {
            return null;
        }
    }

    public static void createOpportunity(List<Account> accounts) {

        List<Opportunity> opportunities = new List<Opportunity>();

        for (Account anAccount : accounts) {
            if (anAccount.Create_opportunity__c) {
                Opportunity oportunity = new Opportunity();
                oportunity.Name = 'Opportunity' + anAccount.Name + Date.today();
                oportunity.StageName = 'Prospection';
                oportunity.CloseDate = Date.today() + 30;  
                oportunity.Account = anAccount;  
                oportunity.AccountId = anAccount.Id;
                opportunities.add(oportunity);
            }
        }

        insert opportunities;
    }

}