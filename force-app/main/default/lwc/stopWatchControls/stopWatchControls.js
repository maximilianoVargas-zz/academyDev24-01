import { LightningElement, track } from 'lwc';

export default class StopWatchControlls extends LightningElement {
    @track showStartBtn = true;

    handleStartTimer() {
        this.dispatchEvent(new CustomEvent('startevent'));
        this.showStartBtn = false;
      }
    
      handleStopTimer() {
        this.dispatchEvent(new CustomEvent('stopevent'));
        this.showStartBtn = true;
      }

      handleResetTimer() {
        this.dispatchEvent(new CustomEvent('resetevent'));
      }
}