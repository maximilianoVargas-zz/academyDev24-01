import { LightningElement, api, wire, track} from 'lwc';
import getCases from '@salesforce/apex/ListOfCasesToCloseController.getCases';
import closeCases from '@salesforce/apex/ListOfCasesToCloseController.closeCases';
import ID_FROM_CASE from '@salesforce/schema/Case.Id';
import CASE_NUMBER_FROM_CASE from '@salesforce/schema/Case.CaseNumber';
import STATUS_FROM_CASE from '@salesforce/schema/Case.Status';
import CLOSE_REASON from '@salesforce/schema/Case.Close_reason__c';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Id', fieldName: ID_FROM_CASE.fieldApiName },
    { label: 'CaseNumber', fieldName: CASE_NUMBER_FROM_CASE.fieldApiName },
    { label: 'Status', fieldName: STATUS_FROM_CASE.fieldApiName },
    { label: 'Reason', fieldName: CLOSE_REASON.fieldApiName, editable: true}
];


export default class ListOfCasesToClose extends LightningElement {
    @api recordId;
    @track columns = columns;
    
    @wire(getCases, {AccountId: '$recordId'})
    cases;
    
    handleSave(event){
        let editedRowsReasons = event.target.draftValues;
        let thereAreBlanks = false;

        let editedReasonsByRow = new Map();

        editedRowsReasons.forEach(element => {
            editedReasonsByRow.set(element.id.split('-')[1], element.Close_reason__c);
        });

        let dataFromRows = this.template.querySelector('lightning-datatable').data;

        let rowsSelected =  this.template.querySelector('lightning-datatable').getSelectedRows();
        if(rowsSelected.length==0){
            const evt = new ShowToastEvent({
                title: 'Error',
                message: 'Select a case to close',
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
        } else{
            let idsFromRowsSelected = [];
            rowsSelected.forEach(element => {
                idsFromRowsSelected.push(element.Id);
            });
    
            let idsFromRowSelectedByRows = new Map();
    
            for (let i = 0; i < dataFromRows.length; i++) {
                if(idsFromRowsSelected.includes(dataFromRows[i].Id)){
                    idsFromRowSelectedByRows.set(i.toString(), dataFromRows[i].Id);     
                }
            }
    
            let reasonsByCaseId = new Map();
    
            idsFromRowSelectedByRows.forEach((value, key) => {
                if(
                    typeof editedReasonsByRow.get(key) == 'undefined' ||
                    editedReasonsByRow.get(key) == null ||
                    editedReasonsByRow.get(key).length == 0 
                    ){
                        thereAreBlanks = true;
                } else {
                    reasonsByCaseId.set(value, editedReasonsByRow.get(key));
                }
            });
    
            if(thereAreBlanks){
                const evt = new ShowToastEvent({
                    title: 'Error',
                    message: 'There are empty reasons fields selected',
                    variant: 'error',
                    mode: 'dismissable'
                });
                this.dispatchEvent(evt);
            } else {
                let casesToUpdate = [];
                reasonsByCaseId.forEach((value, key) => {
                        casesToUpdate.push('{ "id" : "' + key + '" , "reason" : "' + value + '" }');
                });
                
                closeCases({cases: casesToUpdate})
                .then(()=>{
                    const evt = new ShowToastEvent({
                        title: 'Success',
                        message: 'Closed successfuly',
                        variant: 'success',
                        mode: 'dismissable'
                    });
                    this.dispatchEvent(evt);
                    refreshApex(this.cases);
                    this.template.querySelector('lightning-datatable').selectedRows = [];
                    this.template.querySelector('lightning-datatable').draftValues = [];
                });       
            }
        }
    }
}