global class DailyLeadProcessor implements Schedulable {
    global void execute(SchedulableContext ctx) {
        List<Lead> leads = [SELECT LeadSource
                            FROM Lead
                            WHERE LeadSource = null
                            LIMIT 200];

        for (Lead l : leads) {
            l.LeadSource = 'DreamForce';
        }
    }
}