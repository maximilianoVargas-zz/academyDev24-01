import { LightningElement, api, wire } from 'lwc';
import getCasesByAccountId from '@salesforce/apex/closeCasesFromAccountController.getCasesByAccountId';
import updateCases from '@salesforce/apex/closeCasesFromAccountController.updateCases';
import { refreshApex } from '@salesforce/apex';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import CASE_NUMBER_FROM_CASE from '@salesforce/schema/Case.CaseNumber';
import STATUS_FROM_CASE from '@salesforce/schema/Case.Status';
import CLOSE_REASON_FROM_CASE from '@salesforce/schema/Case.Close_Reason__c';


const columns = [
    { label: 'Case Number', fieldName: CASE_NUMBER_FROM_CASE.fieldApiName, type: 'number', editable: false },
    { label: 'Status', fieldName: STATUS_FROM_CASE.fieldApiName, type: 'text', editable: false },
    { label: 'Close Reason', fieldName: CLOSE_REASON_FROM_CASE.fieldApiName, type: 'text', editable: true }
];

export default class DatatableWithInlineEdit extends LightningElement {

    @api recordId;
    columns = columns;
    draftValues = [];


    @wire(getCasesByAccountId, { AccountId: '$recordId'})
    cases;

    async handleSave(event) {
        const updatedFields = event.detail.draftValues;
        
        // Prepare the record IDs for getRecordNotifyChange()
        const notifyChangeIds = updatedFields.map(row => { return { "recordId": row.Id } });
    
            // Pass edited fields to the updateContacts Apex controller
            const result = await updateCases({data: updatedFields});
            console.log(JSON.stringify("Apex update result: "+ result));

            if(result == 'Success: cases updated successfully'){
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: result,
                        variant: 'success'
                    })
                );
            }
            else if(result == 'Close reason field is required'){
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: result,
                        variant: 'error'
                    })
                );
            }
    
            // Refresh LDS cache and wires
            getRecordNotifyChange(notifyChangeIds);
    
            // Display fresh data in the datatable
            refreshApex(this.cases).then(() => {
                // Clear all draft values in the datatable
                this.draftValues = [];
            });
    }
}
