@isTest
public with sharing class TestVerifyDate {
    
    @isTest static void TestDate2InDate1() {
        Date date1 = Date.newInstance(2021, 1, 11);
        Date date2 = Date.newInstance(2021, 1, 11).addDays(10);
        Date date3 = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, date3);
    }

    @isTest static void TestDate2EqualsDate1() {
        Date date1 = Date.newInstance(2021, 1, 11);
        Date date2 = Date.newInstance(2021, 1, 11);
        Date date3 = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, date3);
    }

    @isTest static void TestDate2EqualsDate1And30Days() {
        Date date1 = Date.newInstance(2021, 1, 11);
        Date date2 = Date.newInstance(2021, 1, 11).addDays(30);
        Date date3 = VerifyDate.CheckDates(date1, date2);
        System.assertEquals(date2, date3);
    }

    @isTest static void TestDate2BeforeDate1() {
        Date date1 = Date.newInstance(2021, 1, 11);
        Date date2 = Date.newInstance(2020, 12, 31);
        Date date3 = VerifyDate.CheckDates(date1, date2);
        Integer anio = date1.year();
        Integer mes = date1.month();
        Integer dia = date.daysInMonth(anio, mes);
        System.assertEquals(date.newInstance(anio, mes, dia), date3);
    }

    @isTest static void TestDate2afterDate1And30Days() {
        Date date1 = Date.newInstance(2021, 1, 11);
        Date date2 = Date.newInstance(2021, 3, 23);
        Date date3 = VerifyDate.CheckDates(date1, date2);
        Integer anio = date1.year();
        Integer mes = date1.month();
        Integer dia = date.daysInMonth(anio, mes);
        System.assertEquals(date.newInstance(anio, mes, dia), date3);
    }
}