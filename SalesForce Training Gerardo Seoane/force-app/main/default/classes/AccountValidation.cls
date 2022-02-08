public with sharing class AccountValidation {
    public static string validateAccount(List<Account> ListAccount ) {
        try{
            /*List<Account> InsertList=new List<Account>();

            for(Account anAccount : ListAccount){
                Integer count=[select Count() from Account where Identification_type__c=:anAccount.Identification_type__c and Document_number__c=:anAccount.Document_number__c];
                
                if(count != 0)
                    return 'El registro '+anAccount.Name+' ya existe';                                
            }   */
            return 'Insertado Correctamente';
        }
        catch(DmlException e){
            return 'Error al insertar';  
        }

    }
}