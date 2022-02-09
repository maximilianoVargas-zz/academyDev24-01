//script ejercicio 1
List<Account> accounts = [select Name, Identification_type__c, Document_number__c from Account];
for(Account anAccount: accounts){
    anAccount.Identification_type__c = 'NIT';
    anAccount.Document_number__c = EncodingUtil.base64encode(Crypto.generateAesKey(192)).substring(0, 10);
}

update accounts;