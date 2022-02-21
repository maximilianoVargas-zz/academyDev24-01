import { LightningElement, api, wire } from 'lwc';
import getCases from '@salesforce/apex/closeCases.getCases';
import updateCases from '@salesforce/apex/closeCases.updateCases';
import CASE_NUMBER_FIELD from '@salesforce/schema/Case.CaseNumber';
import CREATED_DATE_FIELD from '@salesforce/schema/Case.CreatedDate';
import CANCELLATION_REASON_FIELD from '@salesforce/schema/Case.Cancellation_Reason__c';
import { updateDataConnector } from 'lightning/analyticsWaveApi';

const columns = [
    { label: 'Case Number', fieldName: CASE_NUMBER_FIELD.fieldApiName, editable: false },
    { label: 'Created Date', fieldName: CREATED_DATE_FIELD.fieldApiName, type: 'date', editable: false },
    { label: 'Reason', fieldName: CANCELLATION_REASON_FIELD.fieldApiName, type: 'text', editable: true }
];

export default class CloseCases extends LightningElement {
    @api recordId;
    @wire(getCases, {accountId: '$recordId'})
    cases;
    columns = columns;
    rowOffset = 0;

    handleSave(event){
        let selected = [];
        for (const row of this.template.querySelector('lightning-datatable').getSelectedRows()) selected.push({...row});

        for (let i = 0; i < selected.length; i++) {
            console.log(event.detail.draftValues[i].id);
            selected[i].Cancellation_Reason__c = event.detail.draftValues[i].Cancellation_Reason__c;
        }

        updateCases({cases: selected}).then(result => {
            this.message = result;
            this.error = undefined;
            if(this.message !== undefined || this.message !== '' || result!==undefined || result !== '' ) {
                alert("Saved Changes.");
                
            }
        })
        .catch(error => {
            this.message = undefined;
            this.error = error;
            alert("error: ", JSON.stringify(this.error));
        });
    }    
}