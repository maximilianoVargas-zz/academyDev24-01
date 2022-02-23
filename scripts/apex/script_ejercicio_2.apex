//script ejercicio 2
List<Account> listAccounts = new List<Account>();
for(Integer i=0; i<50; i++){
Account cuenta = new Account();
cuenta.Name = 'Cuenta de entrenamiento '+i;
cuenta.NumberOfEmployees = i*10;
cuenta.Identification_type__c = 'NIT';
cuenta.Document_number__c = EncodingUtil.base64encode(Crypto.generateAesKey(192)).substring(0, 10);
listAccounts.add(cuenta);
}
insert listAccounts;