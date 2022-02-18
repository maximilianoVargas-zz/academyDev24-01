/*Consult accounts with more than 100 employees
View accounts with more than 200 employees sorted by name
Consult accounts with more than 300 employees ordered by number of employees
Check the 10 accounts with the most employees
Note: For all queries, the fields ID, Account Name, and Number of Employees must be displayed.

 */
public with sharing class SoqlPractice {
    public static void soqlPracticeConsultMoreThan100Employees() {
        List<Account> accounts = [
                        SELECT Id, Name, NumberOfEmployees
                        FROM Account
                        WHERE NumberOfEmployees > 100];
        
        for(Account anAccount:accounts){
            System.debug(anAccount.id +' '+ anAccount.Name +' '+ anAccount.NumberOfEmployees);
        }

    }

    public static void soqlPracticeViewMore200Ordered() {
        List<Account> accounts = [
                        SELECT Id, Name, NumberOfEmployees
                        FROM Account
                        WHERE NumberOfEmployees > 200
                        ORDER BY Name];
        
        for(Account anAccount:accounts){
            System.debug(anAccount.id +' '+ anAccount.Name +' '+ anAccount.NumberOfEmployees);
        }

    }

    public static void soqlPracticeViewMoreTop10Employees() {
        List<Account> accounts = [
                        SELECT Id, Name, NumberOfEmployees
                        FROM Account
                        WHERE NumberOfEmployees > 200
                        ORDER BY NumberOfEmployees DESC
                        LIMIT 10];
        
        for(Account anAccount:accounts){
            System.debug(anAccount.id +' '+ anAccount.Name +' '+ anAccount.NumberOfEmployees);
        }

    }
}
