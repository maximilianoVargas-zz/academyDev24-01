({
	handleClick : function(component, event, helper) {
		var num = component.get("v.num");
        log()
        num = num + 1;
        component.set("v.num", num);
	}
})