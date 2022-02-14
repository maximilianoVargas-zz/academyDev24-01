public with sharing class AccountManage {

    public static void createOpportunity(List<Account> accounts){
        List<Opportunity> newOpportunities = new List<Opportunity>();
        for(Account anAccount : accounts){
            if(anAccount.create_opportunity__c){
                Opportunity newOpportunity = new Opportunity(
                    Name = 'Opportunity' + anAccount.Name + System.today().format(),
                    StageName = 'Prospection',
                    CloseDate = System.today().addDays(30),
                    AccountId = anAccount.Id
                );
                newOpportunities.add(newOpportunity);
            }
        }
        insert newOpportunities;

    }

    public Id createAccount (String name, 
                      Integer numberOfEmployees, 
                      String documentType,
                      String documentNumber){
                          
                          Account newAccount = new Account(
                          	  Name = name, 
                              numberOfEmployees = numberOfEmployees,
                              Identification_type__c = documentType,
                              Document_number__c = documentNumber
                          );
                          
                          insert newAccount;
                          
                          return newAccount.Id;                          
                      }
    
    public Boolean UpdateAccount (String name, 
                      	Integer numberOfEmployees, 
                      	String documentType,
                        String documentNumber){
                            
                            Account cuenta = [SELECT id, Name,
                                              numberOfEmployees,
                                              Identification_type__c,
                                              Document_number__c FROM Account
                                             WHERE Name = :name];
                            cuenta.Name = name;
                            cuenta.NumberOfEmployees = numberOfEmployees;
                            cuenta.Identification_type__c = documentType;
                            cuenta.Document_number__c = documentNumber;
                            
                            Database.SaveResult resultado= Database.update(cuenta, false);
                               
                            return resultado.isSuccess();
                           }
    
    public Boolean DeleteAccount (String documentType,
                           String documentNumber){
                                Account cuenta = [SELECT id FROM Account
                                             WHERE Identification_type__c = :documentType
                                                 and Document_number__c = :documentNumber];
                            Database.DeleteResult resultado= Database.delete(cuenta, false);                               
                            return resultado.isSuccess();
                               
                           }
    
    
    public Account ConsultAccount (String documentType,
                            String documentNumber){
                                 Account cuenta = [SELECT id FROM Account
                                             WHERE Identification_type__c = :documentType
                                                 and Document_number__c = :documentNumber];
                                return cuenta;
                            }

}