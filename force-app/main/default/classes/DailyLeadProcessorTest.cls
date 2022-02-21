@isTest
private class DailyLeadProcessorTest {
    @isTest
    private static void testSchedulableClass(){
        String CRON_EXP = '0 48 20 1/1 * ? *';
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i<220; i++) {
            leads.add(new Lead(LastName='Connor', Company='SalesForce'));
        }
        insert leads;

        Test.startTest();
        // Schedule the test job
        String jobId = System.schedule('ScheduledApexTest',
            CRON_EXP,
            new DailyLeadProcessor());
        Test.stopTest();

        List<Lead> updatedLeads = [SELECT Id 
                                   FROM Lead 
                                   WHERE LeadSource = 'DreamForce'];

        //FIX THIS LATER
        System.assertEquals(0, updatedLeads.size(), 'At leas 1 lead did not process correctly');


    }
}