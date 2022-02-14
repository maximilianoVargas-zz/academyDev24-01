public with sharing class AccountManage {
    public AccountManage() {
        /*
        List<Account> listAccounts = new List<Account>();
        for(Integer i=0; i<50; i++){
            Account cuenta = new Account();
            cuenta.Name = 'Cuenta de entrenamiento '+i;
            cuenta.NumberOfEmployees = i*10;
            listAccounts.add(cuenta);
            }
            insert listAccounts;
        */      
    }

    public static void scriptUpdateAccount()
    {
        List<Account> lastAccount = [SELECT Id, Identification_type__c, Document_number__c FROM Account WHERE name LIKE 'Cuenta de entrenamiento'];
        for (Account anAccount : lastAccount) {
            anAccount.identification_type__c = 'NIT';
            anAccount.Document_number__c = EncodingUtil.base64encode(Crypto.generateAesKey(192)).substring(0, 10);
        }
    }

    public static string createAccount(string name, Integer numberEmployees, string documentType, string documentNumber)
    {
        Account anAccount = new Account();
        anAccount.Name = name;
        anAccount.NumberOfEmployees = numberEmployees;
        anAccount.Identification_type__c = documentType;
        anAccount.Document_Number__c = documentNumber;
        insert(anAccount);
        return anAccount.Id;
    }

    public static boolean updateAccount(string name, Integer numberEmployees, string documentType, string documentNumber)
    {
        try {
            Account anAccount = [SELECT Id,Name,NumberOfEmployees, Identification_type__c, Document_Number__c FROM Account WHERE Name = :name LIMIT 1];
            if(anAccount != null)
            {
                anAccount.NumberOfEmployees = numberEmployees;
                anAccount.Identification_type__c = documentType;
                anAccount.Document_Number__c =  documentNumber;
                Database.SaveResult result = Database.update(anAccount);
                return result.isSuccess();
            }        
            return false;            
        } catch (Exception e) {
            return false;
        }

    }

    public static Boolean deleteAccount(string documentType, string documentNumber)
    {
        try {
            Account anAccount = [SELECT id, name FROM Account WHERE Document_Number__c = :documentNumber LIMIT 1];            
            Database.DeleteResult result = Database.delete(anAccount);
            return result.isSuccess();
        } catch (Exception e) {
            return false;
        }
    }

    public static Account consultAccount(string documentType, String documentNumber)
    {
        try {
            return [SELECT Id, name FROM Account WHERE Document_number__c = :documentNumber AND Identification_type__c = :documentType LIMIT 1];
        } catch (Exception e) {
            return null;
        }
    }

    public static void createOpportunity(List<Account> accounts)
    {
        List<Opportunity> opportunities = new List<Opportunity>();
        for(Account anAccount : accounts)
        {
            if(anAccount.Create_Opportunity__c == true)
            {
                Opportunity anOpportunity = new Opportunity();
                anOpportunity.AccountId = anAccount.Id;
                anOpportunity.Name = 'Opportunity ' + anAccount.Name + System.now().date();
                anOpportunity.StageName = 'Prospection';
                anOpportunity.CloseDate = System.now().date() + 30;
                opportunities.add(anOpportunity);
            }
        }
        insert(opportunities);
    }
    
}