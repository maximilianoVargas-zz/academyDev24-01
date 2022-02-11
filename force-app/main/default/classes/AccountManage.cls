public with sharing class AccountManage {

    public static Id createAccount(String name, Integer numberOfEmployees, 
                                    String documentType, String DocumentNumber){
        Account anAccount = new Account(Name=name,
        NumberOfEmployees=numberOfEmployees,
        Identification_Type__c=documentType,
        Document_Number__c=DocumentNumber);
        insert anAccount;
        return anAccount.Id;
    }

    public static Boolean updateAccount(String name, Integer numberOfEmployees, 
                                        String documentType, String DocumentNumber){
        Account anAccount = consultAccount(documentType, documentNumber);
        if (anAccount != null){
            anAccount.Name = name;
            anAccount.NumberOfEmployees = numberOfEmployees;
            Database.SaveResult result = Database.update(anAccount, false);
            return result.isSuccess();
        }
        else 
            return false;
        
    }

    public static Boolean deleteAccount(String documentType, String DocumentNumber){
       Account anAccount = consultAccount(documentType, documentNumber);
        Database.DeleteResult result = Database.delete(anAccount.Id, false);
        return result.isSuccess();
    }

    public static Account consultAccount(String documentType, String documentNumber){
        try{
            return [ 
                SELECT Id, Name, NumberOfEmployees, Identification_Type__c, Document_Number__c 
                FROM Account
                WHERE Identification_Type__c = :documentType
                AND Document_Number__c = :DocumentNumber
                LIMIT 1
                ];
        }
        catch(Exception e){
            return null;
        }
    }

    public static void createOpportunity(List<Account> accounts){
        List<Opportunity> opportunitiesToInsert = new List<Opportunity>();
        for (Account anAccount : accounts){
            Opportunity newOpportunity = new Opportunity(AccountId=anAccount.Id, 
                                                        Name=anAccount.Name+' new opportunity', 
                                                        StageName='Prospecting', 
                                                        CloseDate=System.today());
            opportunitiesToInsert.add(newOpportunity);
        }
        insert opportunitiesToInsert;
    }
}
