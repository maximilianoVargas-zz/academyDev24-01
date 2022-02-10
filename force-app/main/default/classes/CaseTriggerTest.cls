@Istest
public with sharing class CaseTriggerTest {

    @TestSetup
    static void makeData(){

        List<Task> existingTasks = new List<Task>();   
        List<Contact> existingContacts = new List<Contact>();

        for(Integer i = 0; i<20; i++){
            existingContacts.add(new Contact(
                FirstName = 'Test',
                LastName = 'Contact' + i,
                Email = 'test' + i +'@globant.com'
            ));
        }
        insert existingContacts;

        for(Contact aContact : existingContacts){
            existingTasks.add(
                new Task(
                    WhoId = aContact.Id,
                    Subject = 'Call',
                    Status = 'Not Started'
                )
            );
        }

        insert existingTasks;
    }


    @Istest
    public static void testIfACaseIsAssignedToATaskWhenThatDontHaveNothingAssigned(){
        List<Contact> existingContacts = [
            SELECT Id
            FROM Contact            
        ];
          
        List<Case> newCases = new List<Case>();
        for(Contact aContact: existingContacts){            
            newCases.add(
                new Case(
                 ContactId = aContact.Id
                )
            );

        }
       
        Test.startTest();
        insert newCases;
        Test.stopTest();

        Map<Id, Case> caseById = new Map<Id, Case>();
        for(Case aCase : newCases){
            caseById.put(aCase.Id, aCase);
        }


        List <Task> tasksWithInsertedCases = [
            SELECT Id FROM Task WHERE WhatId IN :caseById.keySet()
        ];

        System.debug('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>' + tasksWithInsertedCases.size());
       
       System.assertEquals(20, tasksWithInsertedCases.size(), 'La cantidad de Tareas no coincide con la cantidad de casos');

    }

}
