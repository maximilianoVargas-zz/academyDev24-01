import { LightningElement } from 'lwc';

export default class Chronometer extends LightningElement {

    time;    
    isPaused;
    startTime;
    intervalId;
    
    connectedCallback() {
        this.resetTime();
    }

    handlePlay() {
        this.isPaused = false;
        let startTime = new Date();
        if (!this.intervalId) {
            this.intervalId = setInterval(() => { 
                    if (!this.isPaused) {
                        let diff = Date.now() - startTime;
                        startTime = new Date();
                        this.time.setMilliseconds(this.time.getMilliseconds() + diff);
                        this.time = new Date(this.time);
                    }
                }, 10);                              
        }
    }

    handlePause() {
        this.isPaused = true;
    }

    handleStop() {
        clearInterval(this.intervalId);
        this.intervalId = null;
        this.resetTime();
    }

    resetTime() {
        this.time = new Date();
        this.time.setHours(0,0,0,0);
        this.isPaused = false;
    }
}