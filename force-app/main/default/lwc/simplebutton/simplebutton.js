import { LightningElement, api } from 'lwc';

export default class Simplebutton extends LightningElement {
   @api label;

   handleAction(event){
      const factor = event.target.dataset.factor;
      this.dispatchEvent(new CustomEvent('action',{
         bubbles: true,
         detail: factor
      }));
   }
}