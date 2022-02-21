@isTest
public class TestVerifyDate {
	@isTest static void CheckDatesTestBeforeThirtyDays() {
        Date date1 = date.today();
        Date date2 = date1.addDays(29);
        Date t = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(t, date2);
    }
    @isTest static void CheckDatesTestAfterThirtyDays() {
        Date date1 = date.today();
        Date date2 = date1.addDays(31);
        Date t = VerifyDate.CheckDates(date1, date2);
        Integer totalDays = Date.daysInMonth(date1.year(), date1.month());
        System.assertEquals(t, Date.newInstance(date1.year(), date1.month(), totalDays));
    }
}