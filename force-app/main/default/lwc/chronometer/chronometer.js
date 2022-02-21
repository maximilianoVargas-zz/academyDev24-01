import { LightningElement, wire } from 'lwc';
import { subscribe, MessageContext } from 'lightning/messageService';
import COUNT_UPDATED_CHANNEL from '@salesforce/messageChannel/Action_chronometer__c';
import { updateRecord } from 'lightning/uiRecordApi';

export default class Chronometer extends LightningElement {

    @wire(MessageContext)
    messageContext;

    subscription = null;

    hours = 0;
    minutes = 0;
    seconds = 0;
    startCount = false;

    subscribeToMessageChannel() {
        this.subscription = subscribe(
          this.messageContext,
          COUNT_UPDATED_CHANNEL,
          (message) => this.handleMessage(message)
        );
        console.log('suscrito');
    }

    connectedCallback() {
        this.subscribeToMessageChannel();
    }

    handleMessage(message) {
        if(message.operation == 'play'){
            console.log('Play');
            this.startTimer();
        }else if(message.operation == 'pause'){
            console.log('Pause');
            this.pauseTimer();
        }else if(message.operation == 'stop'){
            console.log('Stop');
            this.stopTimer();
        }
    }

    pauseTimer(){
        this.startCount = false; 
    }

    stopTimer(){
        this.startCount = false;
        this.hours = 0;
        this.minutes = 0;
        this.seconds = 0;
    }

    startTimer(){
        if(!this.startCount){
            console.log('a contar!');
            this.startCount = true;
            this.timerCycle();
        }
    }

    timerCycle(){
        if(this.startCount){
            this.seconds++;
            console.log('s' + this.seconds);
            if (this.seconds == 60) {
                this.minutes++;
                this.seconds = 0;
            }

            if (this.minutes == 60) {
                this.hours++;
                this.minutes = 0;
                this.seconds = 0;
            }
            
            setTimeout(()=> {this.timerCycle()}, 1000);
        }
    }

}