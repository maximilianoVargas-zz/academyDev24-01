@isTest
public with sharing class AccountValidationTest {
    @TestSetup
    static void makeData(){

        List<Account> accList = new List<Account>();
        Account madeUpAccount1 = new Account(
            Name = 'Toys Were Us',
            Identification_Type__c = 'NIT',
            Document_Number__c = '11222333'
        );
        accList.add(madeUpAccount1);

        Account madeUpAccount2 = new Account(
            Name = 'RIP Activision',
            Identification_Type__c = 'NIT',
            Document_Number__c = '22333444'
        );
        accList.add(madeUpAccount2);

        insert accList;
    }
    
    @isTest
    static void checkIfWhenANewAccountWithExistingIdentityTypeAndDocumentNumberIsCreatedAnErrorIsAdded(){

        List<Account> anAccountList = new List<Account>();

        Account anAccount = new Account(
            Name = 'Duplicate Account',
            Identification_Type__c = 'NIT',
            Document_Number__c = '22333444'
        );

        anAccountList.add(anAccount);

        insert anAccountList;

        Test.startTest();
        AccountValidation.validateAccount(anAccountList);
        Test.stopTest();

        String errorMessage = 'ERROR: An account with this Document Number and Type Already Exits';
        
        List<Account> updatedAccounts = [
            SELECT Name, Conflict_Error__c
            FROM Account
            WHERE Document_Number__c = '22333444'
        ];
        Map<String, Account> accountByConflictError = new Map<String, Account>();
        for (Account acc : updatedAccounts){
            accountByConflictError.put(acc.Conflict_Error__c, acc);
        }

        Boolean errorMessageFound = false;

        for (String s : accountByConflictError.keySet()){
            if (s == errorMessage) {
                errorMessageFound = true;
                break;
            }
        }
        
        System.assert(errorMessageFound == true, 
                            'There is no error message in the tested account or the validation did not work');

    }
}
