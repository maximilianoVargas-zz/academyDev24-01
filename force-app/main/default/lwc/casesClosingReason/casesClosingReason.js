import { LightningElement, wire, api } from 'lwc';
import getCases from '@salesforce/apex/CaseController.getCases';
import updateCases from '@salesforce/apex/CaseController.updateCases';
import { refreshApex } from '@salesforce/apex';
import { getRecordNotifyChange } from 'lightning/uiRecordApi'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';



const COLS = [
    { label: 'Número de Caso', fieldName: 'CaseNumber', editable: false },
    { label: 'Razón de Cierre', fieldName: 'Closing_reason__c', editable: true },
    { label: 'Fecha Creación', fieldName: 'CreatedDate', editable: false }
];

export default class CasesClosingReason extends LightningElement {
    @api recordId;
    columns = COLS;
    draftValues = [];

    @wire(getCases,{accountId: '$recordId'})
    cases;

    async handleSave(event){

        const updatedFields  = event.detail.draftValues;
        const notifyChangeIds = updatedFields.map(row => { return { "recordId": row.Id}});

        try {            
            // Pass edited fields to the updateCases Apex controller
            const result = await updateCases({data: updatedFields });
            console.log(JSON.stringify("Apex update result: " + result));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Case updated',
                    variant: 'success'
                })
            );
    
            // Refresh LDS cache and wires
            getRecordNotifyChange(notifyChangeIds);
    
            // Display fresh data in the datatable
            refreshApex(this.cases).then(() => {
                // Clear all draft values in the datatable
                this.draftValues = [];
            });
       } catch(error) {
               this.dispatchEvent(
                   new ShowToastEvent({
                       title: 'Error updating or refreshing records',
                       message: error.body.message,
                       variant: 'error'
                   })
             );
        };
    }
}