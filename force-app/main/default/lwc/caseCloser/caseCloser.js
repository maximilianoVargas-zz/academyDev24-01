import { api, LightningElement, track, wire } from 'lwc';
import getCasesOfAccount from '@salesforce/apex/CaseCloserController.getCasesOfAccount';
import closeCases from '@salesforce/apex/CaseCloserController.closeCases';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Id', fieldName: 'Id'},
    { label: 'CaseNumber', fieldName: 'CaseNumber' },
    { label: 'Status', fieldName: 'Status' }
];

export default class CaseCloser extends LightningElement {

    @api recordId;  // Account ID
    @track columns = columns;
    
    @wire(getCasesOfAccount, { accountId: '$recordId' })
    cases;

    handleclick(){
        const datatable = this.template.querySelector('lightning-datatable');
        const selectedRows = datatable.getSelectedRows();

        let caseIds = [];
        let parentThis = this;
        if(selectedRows.length > 0) {
            selectedRows.forEach((value) => { 
                caseIds.push(value.Id);
            })
            closeCases({ caseIds: caseIds })
                .then(() => {                    
                    const evt = new ShowToastEvent({
                        title: 'Cases closed',
                        message: 'All selected cases were successfully closed',
                        variant: 'success',
                        mode: 'dismissable'
                    });
                    parentThis.dispatchEvent(evt);
                })
                .catch(() => {
                    const evt = new ShowToastEvent({
                        title: 'Error',
                        message: 'There was an error trying to close the cases',
                        variant: 'error',
                        mode: 'dismissable'
                    });
                    parentThis.dispatchEvent(evt);
                });
        }
    }

}