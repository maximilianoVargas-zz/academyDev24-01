public with sharing class AccountManage {
    
    public static string createAccount(string name, integer numberOfEmploees, string documentType, string documentNumber){
		Account anAccount =  new Account(
			name = name,
			NumberOfEmployees = numberOfEmploees,
			Identification_type__c = documentType,
			Document_Number__c = documentNumber
		);
	
		insert anAccount;
		return anAccount.Id;
    }
    
    public static Boolean updateAccount(string name, integer numberOfEmploees, string documentType, string documentNumber){
        Account anAccount = consultAccount(documentType, documentNumber);
        anAccount.Name = name;
        anAccount.NumberOfEmployees = numberOfEmploees;
        Database.SaveResult result = Database.update(anAccount, false);
        return result.isSuccess();
    }
    
    public static Boolean deleteAccount(string documentType, string documentNumber){
        Account anAccount = consultAccount(documentType, documentNumber);
        if (anAccount == null)
            return false;
        Database.DeleteResult result = Database.delete(anAccount, false);
        return result.isSuccess();
    }
    
    public static Account consultAccount(string documentType, string documentNumber){
        try{
            return [
                SELECT Id, name, NumberOfEmployees, Identification_type__c, Document_Number__c
                FROM Account 
                WHERE Identification_type__c = :documentType 
                AND Document_Number__c = :documentNumber
                LIMIT 1
            ];
        } catch(Exception e){
            return null;
        }
    } 

    public static void createOpportunity(List<Account> accounts) {
        List<Opportunity> opportunities = new List<Opportunity>();
        for (Account anAccount : accounts) {
            if (anAccount.opportunity__c) {
                opportunities.add(new Opportunity(
                    Name='Opportunity ' + anAccount.Name + System.Today(),
                    AccountID=anAccount.Id,
                    StageName='Prospection',
                    CloseDate=System.Today().addDays(30)
                ));
            }
        }
        insert opportunities;
    }
    
}