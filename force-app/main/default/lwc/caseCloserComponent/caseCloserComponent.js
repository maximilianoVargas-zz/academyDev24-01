import { LightningElement, wire, api } from 'lwc';
import getCases from '@salesforce/apex/CaseCloserController.getCases';
import updateCases from '@salesforce/apex/CaseCloserController.updateCases';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import CLOSING_REASON_FIELD from '@salesforce/schema/Case.Closing_Reason__c';
import STATUS_FIELD from '@salesforce/schema/Case.Status';
import ID_FIELD from '@salesforce/schema/Case.Id';

const COLS = [
    { label: 'Case Number', fieldName: 'CaseNumber' },
    { label: 'Closing Reason', fieldName: 'Closing_Reason__c', type: 'text', editable: true },
    { label: 'Status', fieldName: 'Status', type: 'text', editable: false }
];

export default class CaseCloserComponent extends LightningElement {
    @api recordId;
    columns = COLS;
    draftValues = [];

    @wire(getCases, { accId: '$recordId' })
    cases;

    async handleClick(event) {
        
        let casesModified = [];
        let table = this.template.querySelector('.table');

        //Tomo solo los casos que tienen modificaciones en el closing reason.
        const recordInputs =  event.detail.draftValues;

        //Recupero los casos modificados y los filtro si estan en blanco
        recordInputs.forEach(element => {
            const index = element.id.split('-')[1];
            var caseByRow = table.data[index];
            var clonedCase = {...caseByRow};
            if (element.Closing_Reason__c !== ""){
                clonedCase.Closing_Reason__c = element.Closing_Reason__c;
                casesModified.push(clonedCase);
            }
        });

        //Guardo los id de los casos que van a ser modificados.
        //const notifyChangeIds = event.detail.draftValues.map(row => { return { "recordId": row.Id } });


        try {
            await updateCases({cases: casesModified});
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Cases updated',
                    variant: 'success'
                })
            );

            //Actualizo los datos de Lightning data service.
            //getRecordNotifyChange(notifyChangeIds);

            //Actualizo la tabla.
            refreshApex(this.cases).then(() => {
                // Limpio draft values.
                this.draftValues = [];
            });
        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Failed',
                    message: 'Cases were not updated. Error: ' + error.body.message,
                    variant: 'fail'
                })
            );
        }
    }
}