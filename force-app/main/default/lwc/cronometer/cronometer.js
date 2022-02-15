import { LightningElement } from 'lwc';

export default class Cronometer extends LightningElement {

    cronometerNumber = 0;
    timeIntervalInstance;

    handleButtonClick(event) {
        const buttonType = event.detail;
        switch (buttonType) {
            case 'success':
                this.playCronometer();
                break;
            case 'brand':
                this.pauseCronometer();
                break;
            case 'destructive':
                this.stopCronometer();
                break;
        }
    }

    playCronometer() {
        let parentThis = this;
        this.timeIntervalInstance = setInterval(function() {
            parentThis.cronometerNumber += 1;
        }, 1000);
    }

    pauseCronometer() {
        clearInterval(this.timeIntervalInstance);
    }

    stopCronometer() {
        clearInterval(this.timeIntervalInstance);
        this.cronometerNumber = 0;
    }
}