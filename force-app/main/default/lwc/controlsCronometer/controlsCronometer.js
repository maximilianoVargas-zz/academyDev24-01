import { LightningElement, api } from 'lwc';

export default class ControlsCronometer extends LightningElement {
    @api label;
    @api icon;
    @api command;

    handleButton(event) {
        this.dispatchEvent(new CustomEvent('buttonclick',{
            command: this.command
        }));
    }        
}