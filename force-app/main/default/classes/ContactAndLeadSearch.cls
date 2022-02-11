public class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String firstOrLastName){
        List<List<SObject>> searchList = [
            FIND :firstOrLastName
            IN ALL FIELDS
            RETURNING Contact(FirstName, LastName), Lead(FirstName, LastName)
        ];
        return searchList;
    }
}