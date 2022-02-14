public class AccountManage {
    
    public static String createAccount(String Name,Integer NumEmployees,string DocumentType,String DocumentNumber)
    {
        try{
            Account NewAccount= new Account(); 
            Integer count=[select Count() from Account where Identification_type__c=:DocumentType and Document_number__c=:DocumentNumber];
            if(count==0){
                NewAccount.Name=Name;
                NewAccount.NumberOfEmployees=NumEmployees;
                NewAccount.Identification_type__c=DocumentType;
                NewAccount.Document_number__c=DocumentNumber;
                insert NewAccount;
                return NewAccount.Id;
            }
            else
                return 'El Usuario ya Existe';              
        }
        catch(DmlException e){
            return String.valueof(e);
        }        
    }
    
    
    public static Boolean UpdateAccount(String Name,Integer NumEmployees,String DocumentType,String DocumentNumber){
        try{
            Account UpdateAccount= new Account(); 
            Integer count=[select Count() from Account where Identification_type__c=:DocumentType and Document_number__c=:DocumentNumber];
            if(count!=0){
                Account anAccount=[select Id from Account where Identification_type__c=:DocumentType and Document_number__c=:DocumentNumber];
                UpdateAccount.Id=anAccount.Id;
                UpdateAccount.Name=Name;
                UpdateAccount.NumberOfEmployees=NumEmployees;
                UpdateAccount.Identification_type__c=DocumentType;
                UpdateAccount.Document_number__c=DocumentNumber;

                Database.SaveResult result = Database.update(UpdateAccount,false);
                return result.isSuccess(); 
            }

            else
                return false;                  
        }
        catch(DmlException e){
            return false;
        }      
    }
    
    public static Boolean DeleteAccount(string DocumentType,String DocumentNumber){
        try{
            Account anAccount=ConsultAccount(DocumentType,DocumentNumber);
            if(anAccount != null){
                Database.DeleteResult result = Database.delete(anAccount,false);
                return result.isSuccess();
            }
            else
                return false;    
        }
        catch(DmlException e){
            return false;
        }        
    }
    
    public static Account ConsultAccount(string DocumentType,string DocumentNumber){
        try{
            Account anAccount=new Account();
            Integer count=[select Count() from Account where Identification_type__c=:DocumentType and Document_number__c=:DocumentNumber];
            if(count == 0){
                anAccount=null;
                return null;
            }                  
            else{
                anAccount=[select Name,Identification_type__c,Document_number__c from Account where Identification_type__c=:DocumentType and Document_number__c=:DocumentNumber];
                return anAccount;  
            }          
        }
        catch(DmlException e){
            Account anAccount=null;
            return anAccount;
        }
    }   


    public static void createOpportunity(List<Account> Accounts){

        List<Opportunity> Opportunities=new List<Opportunity>();

        for(Account anAccount : Accounts){
            if(anAccount.create_opportunity__c==true){
                Opportunity anOpportunity=new Opportunity();
                anOpportunity.Name='Opportunity ' + anAccount.Name +' '+Date.TODAY();
                anOpportunity.StageName='Prospection';
                anOpportunity.CloseDate=Date.TODAY()+30;
                Opportunities.add(anOpportunity);
            }
        }

        insert Opportunities;
   } 
}