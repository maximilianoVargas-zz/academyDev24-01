public with sharing class AccountHandler {
    public static Account insertNewAccount(String name) {
        Account anAccount = new Account(Name=name);
        Database.SaveResult result = Database.insert(anAccount, false);
        if(result.isSuccess()) return anAccount;
        else return null;
    }
}