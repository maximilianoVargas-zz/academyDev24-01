import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CronometroComponent extends LightningElement {
    hours = 0;
    minutes = 0;
    seconds = 0;
    t = null;

    handleStart(){
        console.log('Starting');
        let that = this;
        this.t = setInterval(function() {
            that.tick();
        }, 1000);
    }

    handleStop(){
        clearInterval(this.t);
        this.seconds = 0;
        this.minutes = 0;
        this.hours = 0;
    }

    handlePause(){
        clearInterval(this.t);
    }

    tick(){
        this.seconds++;
        if (this.seconds >= 60){
            this.seconds = 0;
            this.minutes++;
            if (this.minutes >= 60) {
                this.minutes = 0;
                this.hours++;
            }
        }
    }

    handleEvent(event){
        console.log('Me llego un evento. ' + event.detail);
        var eventType = event.detail;
        switch (eventType) {
            case 'init':
                console.log('mando play');
                this.handleStart();
                break;
            case 'reset':
                console.log('mando stop');
                this.handleStop();
                break;
            case 'hold':
                console.log('mando pause');
                this.handlePause();
                break;
            default:
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Failure',
                        message: 'Something went wrong.',
                        variant: 'fail'
                    })
                    );
                break;
        }

    }
}