import { LightningElement, track } from 'lwc';

export default class StopwatchButton extends LightningElement {
    @track showStartBtn = true;
    start(event) {
        this.showStartBtn = false;
        this.dispatchEvent(new CustomEvent('start'));
    }

    stop(event) {
        this.showStartBtn = true;
        this.dispatchEvent(new CustomEvent('stop'));
    }

    reset(event) {
        this.showStartBtn = true;
        this.dispatchEvent(new CustomEvent('reset'));
    }
}