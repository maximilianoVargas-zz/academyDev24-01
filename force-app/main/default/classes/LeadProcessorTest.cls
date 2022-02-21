@isTest
private class LeadProcessorTest {
	@isTest
    private static void testBatchClass(){
        //Load Test Data
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i<200; i++) {
            leads.add(new Lead(LastName='Connor', Company='SalesForce'));
        }
        insert leads;
        
        //Perform Test
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp,200);
        Test.stopTest();
        
        //Check results
        List<Lead> updatedLeads = [SELECT Id 
                                   FROM Lead 
                                   WHERE LeadSource = 'DreamForce'];
        System.assertEquals(200, updatedLeads.size(), 'At leas 1 lead did not process correctly');
    }
}