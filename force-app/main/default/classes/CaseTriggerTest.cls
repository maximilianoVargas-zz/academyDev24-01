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

       System.assertEquals(20, tasksWithInsertedCases.size(), 'La cantidad de Tareas no coincide con la cantidad de casos');

    }


    @isTest
    public static void whenUpdateResultFieldInParentCaseUpdateRelatedCases(){
        List<Case> newCases = new List<Case>();
        List<Case> relatedCases = new List<Case>();
        for(Integer i = 0; i<20; i++){
            newCases.add(new Case(
                Result__c = 'initial result'
            ));
        }
        insert newCases;

        for(Case aCase: newCases){
            relatedCases.add(new Case(
                Result__c = 'Another result',
                ParentId = aCase.Id
            ));
        }
        insert relatedCases;

        for(Case aCase: newCases){
            aCase.Result__c = 'updated result';
        }

        Test.startTest();
        update newCases;
        Test.stopTest();

        List<Case> cases = [
            SELECT id, Result__c FROM Case WHERE Result__c = 'updated result'
        ];

        System.assertEquals(40, cases.size(), 'Los casos relacionados no fueron actualizados');
        
    }

    @isTest
    public static void whenUpdateResultFieldToBlankInParentCaseUpdateRelatedCases(){
        List<Case> newCases = new List<Case>();
        List<Case> relatedCases = new List<Case>();
        for(Integer i = 0; i<20; i++){
            newCases.add(new Case(
                Result__c = 'initial result'
            ));
        }
        insert newCases;

        for(Case aCase: newCases){
            relatedCases.add(new Case(
                Result__c = 'Another result',
                ParentId = aCase.Id
            ));
        }
        insert relatedCases;

        for(Case aCase: newCases){
            aCase.Result__c = '';
        }

        Test.startTest();
        update newCases;
        Test.stopTest();

        List<Case> cases = [
            SELECT id, Result__c FROM Case WHERE Result__c = ''
        ];

        System.assertEquals(40, cases.size(), 'Los casos relacionados no fueron actualizados');
        
    }
}
