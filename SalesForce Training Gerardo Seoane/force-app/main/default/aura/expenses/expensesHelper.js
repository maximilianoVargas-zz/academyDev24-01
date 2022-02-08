({
   createExpense: function(component, expense) {
        console.log("Accion Helper antes de mandarlo a funcion en controlador del lado del server")
        let action = component.get("c.saveExpense");
       	console.log( JSON.stringify(action));
        action.setParams({
            "expense": expense
        });
        action.setCallback(this, function(response){
            let state = response.getState();
            if (state === "SUCCESS") {
                console.log("Accion que realiza cuando el estado es success");
                let expenses = component.get("v.expenses");
                console.log("Expenses despues del success:"+expenses);
                expenses.push(response.getReturnValue());
                component.set("v.expenses", expenses);
            }
        });
        $A.enqueueAction(action);
    }
})