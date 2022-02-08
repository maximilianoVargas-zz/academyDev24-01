({
    clickBuscar: function(component, event, helper) {
            let NumPersonaje = component.get("v.AtributoBuscarPersonaje");
            helper.BuscarPersonaje(component, NumPersonaje);
    },
    
     clickGuardar: function(component, event, helper) {
            let NumPersonaje = component.get("v.AtributoBuscarPersonaje");
            helper.GuardarPersonaje(component, NumPersonaje);     
    }
})