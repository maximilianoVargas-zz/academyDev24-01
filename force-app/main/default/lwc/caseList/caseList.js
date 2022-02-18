import { LightningElement, api, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import getCasesByAccount from '@salesforce/apex/CaseController.getCasesByAccount';
import CASE_NUMBER_FIELD from '@salesforce/schema/Case.CaseNumber';
import STATUS_FIELD from '@salesforce/schema/Case.Status';
import DESCRIPTION_FIELD from '@salesforce/schema/Case.Description';
import updateCases from '@salesforce/apex/CaseController.updateCases';

const COLS = [
    { label: 'Case number', fieldName: CASE_NUMBER_FIELD.fieldApiName },
    { label: 'Description', fieldName: DESCRIPTION_FIELD.fieldApiName, editable: true },
    { label: 'Status', fieldName: STATUS_FIELD.fieldApiName }
];

export default class CaseList extends LightningElement {

    @api recordId;
    columns = COLS;
    draftValues = [];

    @wire(getCasesByAccount, {idAccount: '$recordId'})
    cases;

    handleCloseCase(event) {
        
        let table = this.template.querySelector('.table');
        let rows =  table.getSelectedRows();

        if (rows.length == 0) {
            this.showMessage('Error updating cases', 'There are not cases selected', 'error');
            return;
        }
        
        let casesToUpdate = new Array();
        
        let descriptionCaseById = new Map();
        event.detail.draftValues.forEach(
            aCase =>  descriptionCaseById.set(aCase.Id, aCase.Description) 
        );
        
        let errorDescription = false;
        rows.forEach(
            aCase => {
                let newDescription = descriptionCaseById.get(aCase.Id);
                if (!newDescription || 0 === newDescription.length) {
                    errorDescription = true;                    
                } else {
                    casesToUpdate.push({
                        'Id': aCase.Id, 
                        'Description': newDescription, 
                        'Status': 'Closed'
                    });
                }                
            }            
        )

        if (errorDescription) {
            this.showMessage('Error updating cases', 'Description message is empty', 'error');
            return;
        }

        updateCases({cases: casesToUpdate})
            .then(() => {
                this.showMessage('Success', 'The selected cases have been closed', 'success');
                return refreshApex(this.cases);
            })
            .catch(error => { 
                this.showMessage('Error updating or refreshing records', error.body.message, 'error');                
            });
        
    }

    showMessage(title, message, typeMessage) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: typeMessage
            })
        );
    }
}