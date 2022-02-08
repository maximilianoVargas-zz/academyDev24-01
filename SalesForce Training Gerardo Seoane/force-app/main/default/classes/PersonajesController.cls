public with sharing class PersonajesController {
  
    @AuraEnabled
    public static ObjPersonajes__c returnPersonaje(Integer numPersonaje) {
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://www.swapi.tech/api/people/'+numPersonaje);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        ObjPersonajes__c p=new ObjPersonajes__c();
        
        if(response.getStatusCode() == 200) {
          
            string urlPlaneta;
            Root responsePersonaje = (Root)JSON.deserialize(response.getBody(), Root.class);
            
            p.Nombre__c=responsePersonaje.result.properties.name;
            p.Altura__c=decimal.valueOf(responsePersonaje.result.properties.height);
            p.Genero__c=responsePersonaje.result.properties.gender;
            p.ColorCabello__c=responsePersonaje.result.properties.hair_color;
            p.ColorOjos__c=responsePersonaje.result.properties.eye_color;
            p.URL__c=responsePersonaje.result.properties.url;
            urlPlaneta=responsePersonaje.result.properties.homeworld;
            p.Planeta__c=ObtenerPlaneta(urlPlaneta);
            p.NumeroPersonaje__c=double.valueOf(responsePersonaje.result.uid);                         
        }            
        return p;  
	}


	@AuraEnabled
    public static string SavePersonaje(ObjPersonajes__c Personaje) {
       
        Integer existe=[SELECT COUNT() FROM ObjPersonajes__c WHERE Nombre__c=:Personaje.Nombre__c];
        if(existe==0){
            insert Personaje;
            return Personaje.Nombre__c; 
        }
        else{
            return 'Existe';
        }  
	}    
    
    
    private static string ObtenerPlaneta(string url)
    {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
        string planeta;
        if(response.getStatusCode() == 200) {
            RootPlaneta responsePlaneta = (RootPlaneta)JSON.deserialize(response.getBody(), RootPlaneta.class);
            planeta=responsePlaneta.result.properties.name;
        }
        return planeta;
    }
    
    //Clases Para obtener Respuesta de url Principal
    public class Properties
    {
        public string height { get; set; }
        public string mass { get; set; }
        public string hair_color { get; set; }
        public string skin_color { get; set; }
        public string eye_color { get; set; }
        public string birth_year { get; set; }
        public string gender { get; set; }
        public DateTime created { get; set; }
        public DateTime edited { get; set; }
        public string name { get; set; }
        public string homeworld { get; set; }
        public string url { get; set; }
    }
    public class Result
    {
        public Properties properties { get; set; }
        public string description { get; set; }
        public string id { get; set; }
        public string uid { get; set; }
        public Integer v { get; set; }
    }
    public class Root
    {
        public string message { get; set; }
        public Result result { get; set; }
    }
    
    //Clases Para obtener Respuesta de url Planeta    
    public class PropertiesPlaneta
    {
        public string diameter { get; set; }
        public string rotation_period { get; set; }
        public string orbital_period { get; set; }
        public string gravity { get; set; }
        public string population { get; set; }
        public string climate { get; set; }
        public string terrain { get; set; }
        public string surface_water { get; set; }
        public DateTime created { get; set; }
        public DateTime edited { get; set; }
        public string name { get; set; }
        public string url { get; set; }
    }
    public class ResultPlaneta
    {
        public PropertiesPlaneta properties { get; set; }
        public string description { get; set; }
        public string aid { get; set; }
        public string uid { get; set; }
        public Integer v { get; set; }
    }
    public class RootPlaneta
    {
        public string message { get; set; }
        public ResultPlaneta result { get; set; }
    }

}