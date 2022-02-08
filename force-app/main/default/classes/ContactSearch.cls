public with sharing class ContactSearch {
    public static List<Contact> searchForContacts(String lastname, String mailing) {
        List<Contact> contacts = [
            SELECT Id, Name
            FROM Contact
            WHERE MailingPostalCode = :mailing
            AND LastName = :lastname
        ];
        return contacts;
    }
}