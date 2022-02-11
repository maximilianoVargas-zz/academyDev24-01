public class AccountHandler {
    public static Account insertNewAccount(String accountName){
        try{
            Account account = new Account(Name=accountName);
            insert account;
            return account;
        } catch(Exception e){
            System.debug('A DML Exception has ocurred: ' + e.getMessage());
            return null;
        }
        
        
    }
}