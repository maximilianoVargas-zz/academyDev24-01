public with sharing class FormController {
	@AuraEnabled
    public static List<String> getResp(Integer param){
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://swapi.dev/api/people/' + param); //aca va param
        request.setMethod('GET');
        request.setHeader('Content-Type', 'application/json');
        request.setHeader('Accept', 'application/json');
        HttpResponse response = http.send(request);
        
        //variable para retornar
        List<String> result = new List<String>();
        
        
        if(response.getStatusCode() == 200) {
            // deserealizacion del Json
            Map<String,Object> mapa = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            
            //obtengo los campos recibidos de la API y los agrego al resultado
            result.add(mapa.get('name').toString());
            result.add(mapa.get('height').toString());
            result.add(mapa.get('gender').toString());
            result.add(mapa.get('hair_color').toString());
            result.add(mapa.get('eye_color').toString());
            result.add(mapa.get('url').toString());
            result.add(mapa.get('homeworld').toString());
            result.add(String.valueOf(param));            
        }  
        else {
            result.add(null);
        }
        
        return result;
    }
        
    @AuraEnabled   
    public static String saveContact(
        String  param_name,
        String  param_height,
        String  param_gender,
        String  param_hair_color,
        String  param_eye_color,
        String  param_url,
        String  param_homeworld,
        String  param_character_number
    ){
     	Contact contact = new Contact();
        String nombre = param_name.split(' ')[0];
        String apellido = '';
        for(Integer i = 1; i<param_name.split(' ').size(); i++){
            if(i!=1)
                apellido = apellido + ' ';
            apellido = apellido + param_name.split(' ')[i];
        }
        if(apellido=='') apellido = '-';
       	contact.put('FirstName', nombre);
        contact.put('LastName', apellido);
        contact.put('Height__c', Integer.valueOf(param_height));
        contact.put('Gender__c', param_gender);
        contact.put('HairColor__c', param_hair_color);
        contact.put('EyeColor__c', param_eye_color);
        contact.put('URL__c', param_url);
        contact.put('Homeworld__c', param_homeworld);
        contact.put('CharacterNumber__c', Integer.valueOf(param_character_number));
        
        List<Contact> contactos = [SELECT Name FROM Contact WHERE FirstName = :nombre and LastName = :apellido];
        if(!contactos.isEmpty()) return 'ya existe un registro para ese personaje';
        else insert contact;
        return 'el personaje ha sido guardado';
    }
}