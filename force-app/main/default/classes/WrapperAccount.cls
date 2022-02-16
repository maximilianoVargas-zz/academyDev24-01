public class WrapperAccount{
    public Account anAccount {get;set;}
    public Boolean isSelected {get;set;}

    public WrapperAccount (Account anAccount){
        this.anAccount = anAccount;
        this.isSelected = false;
    }
} 
