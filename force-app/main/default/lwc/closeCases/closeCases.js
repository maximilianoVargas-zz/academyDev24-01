import { api, LightningElement, wire } from 'lwc';
import getOpenCases from '@salesforce/apex/CloseCaseController.getOpenCases';
import updateCases from '@salesforce/apex/CloseCaseController.updateCases';
import CASE_NUMBER_FROM_CASE from '@salesforce/schema/Case.CaseNumber';
import STATUS_FROM_CASE from '@salesforce/schema/Case.Status';
import CANCEL_REASON_FROM_CASE from '@salesforce/schema/Case.Cancel_Reason__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import { refreshApex } from '@salesforce/apex';

const columns = [{label: 'Case Number', fieldName: CASE_NUMBER_FROM_CASE.fieldApiName},
                {label: 'Status', fieldName: STATUS_FROM_CASE.fieldApiName},
                {label: 'Reason', fieldName: CANCEL_REASON_FROM_CASE.fieldApiName, editable: true}
];

export default class CloseCases extends LightningElement {
    @api recordId;
    columns = columns;
  
    @wire(getOpenCases, {accountId: '$recordId'})
    cases;

    handleSave(event){

        const updatedFields = event.target.draftValues;
        const notifyChangeIds = updatedFields.map(row => { return { "recordId": row.Id } });
        let casesToUpdate = [];
        
        for (const updatedFiel of updatedFields) {           
            let position = parseInt(updatedFiel.id.replace( /^\D+/g, ''));           
            let aCase = this.cases.data[position];           
            let responseCase = {
                id : aCase.Id,
                Cancel_Reason__c : updatedFiel.Cancel_Reason__c,
                Status : 'Closed'
            };           
            casesToUpdate.push(responseCase);
        }

        
        
        try{
            const result = updateCases({data: casesToUpdate}).then((response) =>{
                console.log(JSON.stringify("Apex case update result: "+ response));
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Contact updated',
                        variant: 'success'
                    })
                );
                getRecordNotifyChange(notifyChangeIds);

                // Display fresh data in the datatable
                refreshApex(this.cases).then(() => {
                    // Clear all draft values in the datatable
                    this.casesToUpdate = [];
                });
            }
            );
           
            
        }catch(error){

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or refreshing records',
                    message: error.body.message,
                    variant: 'error'
                })
          );

        }
             
    }


}