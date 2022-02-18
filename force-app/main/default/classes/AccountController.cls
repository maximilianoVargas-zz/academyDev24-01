public with sharing class AccountController {

    public static void updateAccounts(){
        Integer len = 10;
        String str = null;
        String randomNumber = null;

        List<Account> accounts =[
            SELECT Name,DocumentNumber__c,IdentificationType__c 
            FROM Account WHERE Name LIKE '%Cuenta de entrenamiento%' 
            LIMIT 200
        ];
        for (Account account : accounts){
            str=string.valueof(Math.abs(Crypto.getRandomLong()));
            randomNumber=str.substring(0, len);
            system.debug('Random Number-' + randomNumber);

            account.IdentificationType__c='NIT';
            account.DocumentNumber__c=randomNumber;
            System.debug('updated account: ' + account);
            update account;
        }
    }

    /*
    APEX Practice (1 Hour)
Create in the object counts the following fields:
Identification type: List field with the values CC, TI, PP, NIT
Document number: Text fields with a length of 30 characters
Create an Apex language script that queries the 50 accounts created and updates the Identification type fields with the NIT value and Document number with a 10-digit random number.
EncodingUtil.base64encode(Crypto.generateAesKey(192)).substring(0, 10);
    */
}