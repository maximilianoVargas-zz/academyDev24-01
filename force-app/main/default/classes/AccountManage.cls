public with sharing class AccountManage {
    public static Id createAccount(
        String name, 
        Integer number_employees, 
        String document_type, 
        String document_number){
            if(name == null || number_employees == null || document_type == null || document_number == null){
                throw new IllegalArgumentException('The parameters must not be null');
            }
            Account anAccount = new Account(
                Name = name, 
                NumberOfEmployees = number_employees, 
                Identification_type__c = document_type, 
                Document_number__c = document_number); 
                insert anAccount;       
            return anAccount.Id;
    }
    
    public static Boolean UpdateAccount(
    	String name, 
        Integer number_employees, 
        String document_type, 
        String document_number){
            List<Account> accounts = [select Name, NumberOfEmployees, Identification_type__c, Document_number__c 
                                from Account
                                where Document_number__c = :document_number
                                and Identification_type__c = :document_type
                                and Name = :name
                                LIMIT 1];
            if(accounts.isEmpty()) return false;
            Account anAccount = accounts[0];
            anAccount.Name = name;
            anAccount.NumberOfEmployees = number_employees; 
            anAccount.Identification_type__c = document_type; 
            anAccount.Document_number__c = document_number;
            Database.SaveResult result = Database.update(anAccount, false);
            return result.isSuccess();
        }
    
    public static Boolean DeleteAccount(
        String document_type, 
        String document_number){
            List<Account> accounts = [select Identification_type__c, Document_number__c 
                                  from Account
                                  where Identification_type__c = :document_type
                                  and Document_number__c = :document_number];
           	if(accounts.isEmpty()) return false;
            Account anAccount = accounts[0];
            Database.DeleteResult result = Database.delete(anAccount.Id);
            return result.isSuccess();
    }
    
    
    public static Account ConsultAccount(
        String document_type, 
        String document_number){
            List<Account> accounts = [select Name, NumberOfEmployees, Identification_type__c, Document_number__c 
                                 	  from Account
                                      where Identification_type__c = :document_type
                               	 	  and Document_number__c = :document_number];
            if(accounts.isEmpty()) return null;
            return accounts[0];
        }

    public static void createOpportunity(List<Account> accounts){
        List<Opportunity> opportunities = new List<Opportunity>();
        for(Account anAccount : accounts){
            if(anAccount.Create_opportunity__c){
                Date dateNow = System.today();
                Opportunity anOpportunity = new Opportunity(
                    Name='Opportunity' + anAccount.Name + dateNow,
                    StageName = 'Prospection',
                    closeDate = dateNow.addDays(30),
                    AccountId = anAccount.Id);
                opportunities.add(anOpportunity);
            }
        }
        insert opportunities;
    }
}