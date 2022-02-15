import { api, LightningElement } from 'lwc';

export default class Button extends LightningElement {

    @api type;
    @api icon;

    handleClick() {
        this.dispatchEvent(new CustomEvent('buttonclick',{
            detail: this.type
        }));
    }
}