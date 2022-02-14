public with sharing class AccountValidation {
    public static string validateAccount(List<Account> Accounts,string Operation) {
        try{
            List<Account> InsertAccounts=new List<Account>();
            Integer error=0;
    
            for(Account anAccount : Accounts){
                Integer count=[select Count() from Account where Identification_type__c=:anAccount.Identification_type__c and Document_number__c=:anAccount.Document_number__c];
                
                if(count != 0 && Operation=='Add'){
                    error=1;
                    anAccount.addError('El registro '+anAccount.Name+' ya existe');
                }                                  
            }
            if(error==0)
                return 'Insertado Correctamente';
            
            else
                return 'El registro ya existe';
        }
        catch(DmlException e){
            return string.valueOf(e);  
        }
    
    }
}
