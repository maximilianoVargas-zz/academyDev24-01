public with sharing class TriggerExercise1 {

    //TODO - REALIZAR PRUEBAS UNITARIAS
    public static void relatedTask(List<Case> cases) {
        Map<Id,Case> caseByContactId=new Map<Id,Case>();
        List<Task> taskCustom= new List<Task>();
        taskCustom=[select Id,WhatId,WhoId from Task limit 20];


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