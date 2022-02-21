import { LightningElement, api } from 'lwc';

export default class ChronometerButton extends LightningElement {
    
    @api typeButton;
    @api buttonIcon;

    handleClickButton() {
        const buttonEvent = new CustomEvent('clickbutton');
        this.dispatchEvent(buttonEvent);
    }
    
}