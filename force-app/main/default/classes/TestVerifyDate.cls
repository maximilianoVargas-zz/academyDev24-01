@isTest
public class TestVerifyDate {

    @isTest
    static void date2Within30DaysDate1() {
        Date returnDate1 = VerifyDate.CheckDates(date.valueOf('2020-02-14'),date.valueOf('2020-02-24'));
        System.assertEquals(date.valueOf('2020-02-24'), returnDate1);
    }
    
    @isTest
    static void date2NotWithin30DaysDate1() {
        Date returnDate2 = VerifyDate.CheckDates(date.valueOf('2020-02-14'),date.valueOf('2020-03-24'));
        System.assertEquals(date.valueOf('2020-02-29'), returnDate2);
    }
}