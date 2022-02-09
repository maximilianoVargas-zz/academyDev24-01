public with sharing class TriggerExercise1 {

    //TODO - REALIZAR PRUEBAS UNITARIAS
    public static void relatedTask(List<Case> cases) {
        Map<Id,Case> caseByContactId=new Map<Id,Case>();

        //Generacion de map de map , key -> contacid , value -> case
        for (Case aCase : cases) {
            caseByContactId.put(aCase.ContactId,aCase);
        }

        //Tiepo actual menos dos minutos
        Datetime aDate=Datetime.now().addMinutes(-2);

        //Lista de tareas que :
        /*
        - El cliente tiene un call con nada asignado -> EL contacto tiene un tarea con un what id nulo  
        - Relacion de contacto con tarea por medio de id y whoid 
        - fecha de creacion de tarea debe ser mayor a 2 minutos

        - Seleccionar todas las tareas que tengan un what id nulo y whoid esten relacionadas con el id de contacto relacionado con algun caso y fecha de creacion de la tare sea mayor en dos minutos a la fecha actual
        */
        List<Task> tasks=
        [select Id, WhoId from Task 
        where WhatId=null
        and WhoId in :caseByContactId.keySet()
        and CreatedDate >= :aDate
        ];

        for (Task aTask: tasks){
            Case aCase=caseByContactId.get(aTask.WhoId);
            aTask.WhatId=aCase.Id;
        }

        update tasks;
    }


}
/*
First exercise:

Problematic: We want that when creating a case, if the client has a call with nothing assigned and that has been created with a difference of two minutes with the case, that last call is automatically assigned to the created case, in the event that it does not exist a call that meets the above conditions, no call should be assigned to the created case.

Points to solve:

1 - Carry out a test that proves that a call (Task) created for the same client (contact) in the case with the aforementioned conditions is correctly assigned.

2 - Create another that tests that if the call was created 4 minutes before the case, nothing is assigned.

Tips to solve the exercise: Remember the TDD cycle in which you must first write a test that failed, then you must elbow the minimum and essential for the test to pass, make the solution refactor without affecting the operation of the code.

-To do the second test, investigate the Test.SetCreatedDate (id, Date) method;


*/