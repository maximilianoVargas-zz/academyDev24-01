public with sharing class AccountSelected {
    public Boolean selected {get; set;}
    public Account account {get; set;}

    public AccountSelected(Boolean selected, Account account) {
        this.selected = selected;
        this.account = account;
    }
}
