public with sharing class ContactAndLeadSearch {
    public static List<List<SObject>> searchContactsAndLeads(String param) {
        List<List<SObject>> lista = [
            FIND :param 
            IN NAME FIELDS
            RETURNING Contact(FirstName,LastName), Lead(FirstName, LastName)
            ];
        return lista;
    }
}