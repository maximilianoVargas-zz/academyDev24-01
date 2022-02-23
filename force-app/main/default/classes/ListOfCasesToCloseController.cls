public with sharing class ListOfCasesToCloseController {
    
    @AuraEnabled(cacheable=true)
    public static List<Case> getCases(Id AccountId){
        return [
            SELECT Id, CaseNumber, Status, Close_reason__c
            FROM Case
            WHERE AccountId = :AccountId
            AND Status != 'Closed'
        ];
    }

    @AuraEnabled(cacheable=false)
    public static void closeCases(List<String> cases){

        List<ListOfCasesToCloseController.CaseData> dataList = new List<ListOfCasesToCloseController.CaseData>();
        for (String aCase : cases) {
            dataList.add((ListOfCasesToCloseController.CaseData) System.JSON.deserialize(aCase,ListOfCasesToCloseController.CaseData.class));
        }
        
        Map<Id,String> reasonsById = new Map<Id,String>();
        for (ListOfCasesToCloseController.CaseData aData : dataList) {
            reasonsById.put(aData.id, aData.reason);
        }

        List<Case> casesFromDB = [
            SELECT Id, Status
            FROM Case
            WHERE Id IN :reasonsById.keySet()
        ];

        for (Case aCase : casesFromDB) {
            aCase.Status = 'Closed';
            aCase.Close_reason__c = reasonsById.get(aCase.Id);
        }
        
        update casesFromDB;
    }

    public class CaseData {

        public String id;    
        public String reason;    
        
    }
}
