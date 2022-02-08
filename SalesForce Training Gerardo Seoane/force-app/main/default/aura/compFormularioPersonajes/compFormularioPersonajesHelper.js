({
   BuscarPersonaje: function(component, Personaje) {
        let action = component.get("c.returnPersonaje");
        action.setParams({
            "numPersonaje": Personaje.NumeroPersonaje__c
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            
            if (state === "SUCCESS") {
                let Personaje =response.getReturnValue();
				this.LlenarForm(component,Personaje);           
                if(idPersonaje.Nombre__c==undefined)
                      this.MensajeErrorID();
            }         
            else{
                this.refrescarForm(component);
                this.MensajeErrorID();
            }
        });
        $A.enqueueAction(action);
    },
    
    GuardarPersonaje: function(component, Personaje) {
       if(Personaje.NumeroPersonaje__c==undefined)
            this.MensajeError();           
       else{      
        let action = component.get("c.SavePersonaje");
        action.setParams({
            "Personaje": Personaje
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            
            if (state === "SUCCESS") {
                let respuesta =response.getReturnValue();
                
                if(respuesta=='Existe')
                    this.MensajeExiste();                                  
                else{           
                    this.MensajeAgregado();
                    this.refrescarForm(component);                    
                }    
            }
        });
        $A.enqueueAction(action);
    }
   },
    
    refrescarForm: function(component){
       				component.set("v.AtributoBuscarPersonaje.Nombre__c",'');
                    component.set("v.AtributoBuscarPersonaje.Altura__c",'');
                    component.set("v.AtributoBuscarPersonaje.Genero__c",'');
                    component.set("v.AtributoBuscarPersonaje.ColorCabello__c",'');
                    component.set("v.AtributoBuscarPersonaje.ColorOjos__c",'');
                    component.set("v.AtributoBuscarPersonaje.URL__c",'');
                    component.set("v.AtributoBuscarPersonaje.Planeta__c",'');
                    component.set("v.AtributoBuscarPersonaje.NumeroPersonaje__c",''); 
    },
    
    LlenarForm: function(component,Personaje){
       				component.set("v.AtributoBuscarPersonaje.Nombre__c", Personaje.Nombre__c);
                component.set("v.AtributoBuscarPersonaje.Altura__c", Personaje.Altura__c);
                component.set("v.AtributoBuscarPersonaje.Genero__c", Personaje.Genero__c);
                component.set("v.AtributoBuscarPersonaje.ColorCabello__c", Personaje.ColorCabello__c);
                component.set("v.AtributoBuscarPersonaje.ColorOjos__c", Personaje.ColorOjos__c);
                component.set("v.AtributoBuscarPersonaje.URL__c", Personaje.URL__c);
                component.set("v.AtributoBuscarPersonaje.Planeta__c", Personaje.Planeta__c);
                component.set("v.AtributoBuscarPersonaje.NumeroPersonaje__c", Personaje.NumeroPersonaje__c); 
    },
    
    MensajeAgregado : function(component, event, helper) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        mode:'dismissible',
        type:'success',
        "title": "Éxito",
        "message": "El Personaje se Agrego Correctamente"
    });
    toastEvent.fire();
	},
    
    MensajeError : function(component, event, helper) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        mode:'dismissible',
        type:'error',
        "title": "Error",
        "message": "No se puede guardar un registro vacio"
    });
    toastEvent.fire();
	},
    
    MensajeErrorID : function(component, event, helper) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        mode:'dismissible',
        type:'error',
        "title": "Error",
        "message": "El ID proporcionado no es valido"
    });
    toastEvent.fire();
	},
    
    MensajeExiste : function(component, event, helper) {
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        mode:'dismissible',
        type:'warning',
        "title": "Aviso",
        "message": "El Personaje ya esta guardado en base de datos"
    });
    toastEvent.fire();
	}
    
    
})