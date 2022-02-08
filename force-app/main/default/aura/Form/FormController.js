({
  searchClick: function(component) {
    if (typeof component.get("v.num") == "undefined")
      alert("ingresa un numero");
    else {
      var action = component.get("c.getResp");
      action.setParams({ param: component.get("v.num") });

      //variable para guardar la respuesta del controlador apex
      let respuesta;

      action.setCallback(this, function(response) {
        var state = response.getState();
        if (state === "SUCCESS") {
          respuesta = response.getReturnValue();
          if (respuesta[0] == null) alert("el personaje no existe");
          else {
            //setteo los campos del formulario con los datos recibidos
            component.set("v.name", respuesta[0]);
            if (respuesta[0] == "n/a") {
              component.set("v.nameBlocked", false);
              component.set("v.name", '');
            } else component.set("v.nameBlocked", true);
            component.set("v.height", parseInt(respuesta[1]));
            if (respuesta[1] == "n/a") {
              component.set("v.heightBlocked", false);
              component.set("v.height", '');
            } else component.set("v.heightBlocked", true);
            component.set("v.gender", respuesta[2]);
            if (respuesta[2] == "n/a") {
              component.set("v.genderBlocked", false);
              component.set("v.gender", '');
            } else component.set("v.genderBlocked", true);
            component.set("v.haircolor", respuesta[3]);
            if (respuesta[3] == "n/a") {
              component.set("v.haircolorBlocked", false);
              component.set("v.haircolor", '');
            } else component.set("v.haircolorBlocked", true);
            component.set("v.eyescolor", respuesta[4]);
            if (respuesta[4] == "n/a") {
              component.set("v.eyescolorBlocked", false);
              component.set("v.eyescolor", '');
            } else component.set("v.eyescolorBlocked", true);
            component.set("v.url", respuesta[5]);
            if (respuesta[5] == "n/a") {
              component.set("v.urlBlocked", false);
              component.set("v.url", '');
            } else component.set("v.urlBlocked", true);
            component.set("v.planet", respuesta[6]);
            if (respuesta[6] == "n/a") {
              component.set("v.planetBlocked", false);
              component.set("v.planet", '');
            } else component.set("v.planetBlocked", true);
            component.set("v.character_number", respuesta[7]);
            if (respuesta[7] == "n/a") {
              component.set("v.character_numberBlocked", false);
              component.set("v.character_number", '');
            } else component.set("v.character_numberBlocked", true);
          }
        } else {
          alert("error en la consulta, por favor intente de nuevo");
        }
      });
      $A.enqueueAction(action);
    }
  },

  saveClick: function(component) {
    var action = component.get("c.saveContact");
    action.setParams({
      param_name: component.get("v.name"),
      param_height: component.get("v.height"),
      param_gender: component.get("v.gender"),
      param_hair_color: component.get("v.haircolor"),
      param_eye_color: component.get("v.eyescolor"),
      param_url: component.get("v.url"),
      param_homeworld: component.get("v.planet"),
      param_character_number: component.get("v.character_number")
    });

    action.setCallback(this, function(response) {
      alert(response.getReturnValue());
    });

    if (
      component.get("v.name") == "" ||
      component.get("v.height") == "" ||
      component.get("v.gender") == "" ||
      component.get("v.haircolor") == "" ||
      component.get("v.eyescolor") == "" ||
      component.get("v.url") == "" ||
      component.get("v.planet") == "" ||
      component.get("v.character_number") == ""
    )
      alert("No dejes campos vacios");
    else {
      $A.enqueueAction(action);
    }
  }
});