public class WrapperAccount {
    public Boolean selected {get; set;}
    public Account account {get; set;}
    public WrapperAccount(Account account) {
        this.account = account;
        this.selected = false;
    }
}