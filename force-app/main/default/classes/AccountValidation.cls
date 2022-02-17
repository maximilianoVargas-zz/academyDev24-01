public class AccountValidation {

    public static void validateAccount(List<Account> accounts) {

        Set<String> toCompareType = new Set<string>();
        Set<String> toCompareNumber = new Set<string>();
        for (Account anAccount : accounts) {
            toCompareType.add(anAccount.Identification_type__c);
            toCompareNumber.add(anAccount.Document_Number__c);
        }

        List<Account> accountsToCompare = [
            SELECT Id, name, NumberOfEmployees, Identification_type__c, Document_Number__c
            FROM Account 
            WHERE Identification_type__c IN :toCompareType
            	AND Document_Number__c IN :toCompareNumber
        ];
        
        for (Account anAccount1 : accounts) {
            for (Account anAccount2 : accountsToCompare) {
                if (anAccount1.Document_Number__c == anAccount2.Document_Number__c
                    && anAccount1.Identification_type__c == anAccount2.Identification_type__c
                    && anAccount1.Id != anAccount2.Id)
	            anAccount1.AddError('There is already a Account with that name.');
            }
        }
        
    }
    
}