public with sharing class AccountManage {

    public static String createAccount(String name, Integer numberOfEmployees, String documentType, String documentNumber) {
        Account anAccount = new Account(
            Name = name,
            NumberOfEmployees = numberOfEmployees,
            Identification_Type__c = documentType,
            Document_Number__c = documentNumber
        );

        insert anAccount;
        return anAccount.Id;
    }

    public static Boolean updateAccount(String name, Integer numberOfEmployees, String documentType, String documentNumber) {
        Account anAccount = consultAccount(documentType, documentNumber);
        if(anAccount == null) 
            return false;
        anAccount.Name = name;
        anAccount.numberOfEmployees = numberOfEmployees;
        Database.SaveResult result = Database.update(anAccount,false);
        return result.isSuccess();
    }

    public static Boolean deleteAccount(String documentType, String documentNumber) {
        Account anAccount = consultAccount(documentType, documentNumber);
        if(anAccount == null)
            return false;
        Database.DeleteResult result = Database.delete(anAccount);
        return result.isSuccess();
    }

    public static Account consultAccount(String documentType, String documentNumber) {
        List<Account> accounts = [
            SELECT ID, Name, NumberOfEmployees, Identification_Type__c, Document_Number__c
            FROM Account
            WHERE (Identification_Type__c = :documentType AND Document_Number__c = :documentNumber) 
        ];
        if(accounts.isEmpty()) {
            return null;
        }
        return accounts.get(0); // Single result
    }

    public static void createOpportunity(List<Account> accounts) {
        List<Opportunity> opportunitiesToCreate = new List<Opportunity>();
        for(Account anAccount : accounts) {
            if(anAccount.Create_Opportunity__c) {
                opportunitiesToCreate.add(
                    new Opportunity(
                        Name = 'Opportunity' + anAccount.Name + date.today().addDays(30).format(),
                        StageName = 'Prospection',
                        CloseDate = date.today().addDays(30),
                        accountId = anAccount.Id
                    )
                );
            }
        }
        if(opportunitiesToCreate.size() > 0) {
            insert opportunitiesToCreate;
        }
    }
}