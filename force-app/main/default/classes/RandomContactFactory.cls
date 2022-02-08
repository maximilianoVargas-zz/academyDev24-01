public with sharing class RandomContactFactory {
    public static List<Contact> generateRandomContacts (Integer cantidad, String apellido) {
        List<Contact> lista = new List<Contact>();
        for(Integer i = 1; i<=cantidad; i++) lista.add(new Contact(FirstName = 'Prueba ' + i, LastName = apellido));
        return lista;
    }
}