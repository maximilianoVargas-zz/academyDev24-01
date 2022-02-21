import { LightningElement, api } from 'lwc';

export default class CronometroBotonComponent extends LightningElement {
    @api type;
    @api icon;

    handleButton(event){
        console.log('disparo evento');
        this.dispatchEvent(new CustomEvent('buttonclick', {
            detail: this.type
        }));
    }
}