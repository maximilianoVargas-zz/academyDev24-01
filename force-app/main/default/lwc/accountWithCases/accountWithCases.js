import { LightningElement, api, wire } from 'lwc';
import getCases from '@salesforce/apex/AccountWithCasesController.getCases';
import updateCases from '@salesforce/apex/AccountWithCasesController.updateCases';
import CASE_NUMBER_FIELD from '@salesforce/schema/Case.CaseNumber';
import CREATED_DATE_FIELD from '@salesforce/schema/Case.CreatedDate';
import CLOSING_REASON_FIELD from '@salesforce/schema/Case.Closing_Reason__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Case Number', fieldName: CASE_NUMBER_FIELD.fieldApiName, editable: false },
    { label: 'Created Date', fieldName: CREATED_DATE_FIELD.fieldApiName, type: 'date', editable: false },
    { label: 'Reason', fieldName: CLOSING_REASON_FIELD.fieldApiName, type: 'text', editable: true }
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
            selected[i].Closing_Reason__c = event.detail.draftValues[i].Closing_Reason__c;
            if (selected[i].Closing_Reason__c == ''){
                const toastEventError = new ShowToastEvent({
                    title: "Error",
                    message: "Field Must Have a Closing Reason",
                    variant: "Error"
                });
                this.dispatchEvent(toastEventError);
            } else {
                const toastEvent = new ShowToastEvent({
                    title: "Record Updated",
                    message: "The Case Was Updated and Closed",
                    variant: "success"
                });
                this.dispatchEvent(toastEvent);
            }
        }

        updateCases({cases: selected}).then(result => {
            this.message = result;
            this.error = undefined;
            // if(this.message !== undefined || this.message !== '' || result!==undefined || result !== '' ) {
            //     const toastEvent = new ShowToastEvent({
            //         title: "Record Updated",
            //         message: "A Closing Reason has been updated",
            //         variant: "success"
            //     });
            //     this.dispatchEvent(toastEvent);
                
            // } else {

            //     const toastErrorEvent = new ShowToastEvent({
            //         title: "Record Not Updated",
            //         message: "A Closing Reason Must Be Submited And the Field Selected",
            //         variant: "error"
            //     });
            //     this.dispatchEvent(toastErrorEvent);

            // }
        })
        .catch(error => {
            this.message = undefined;
            this.error = error;
            alert("error: ", JSON.stringify(this.error));
        });
    }    

}