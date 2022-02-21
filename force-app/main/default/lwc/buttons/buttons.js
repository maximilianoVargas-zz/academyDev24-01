import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import COUNT_UPDATED_CHANNEL from '@salesforce/messageChannel/Action_chronometer__c';

export default class Buttons extends LightningElement {
    
    @wire(MessageContext)
    messageContext;

    handleStartChronometer(){
        const action = {
            operation : 'play'
        };
        publish(this.messageContext, COUNT_UPDATED_CHANNEL, action);
    }

    handleStopChronometer(){
        const action = {
            operation : 'stop'
        };
        publish(this.messageContext, COUNT_UPDATED_CHANNEL, action);
    }

    
    handlePauseChronometer(){
        const action = {
            operation : 'pause'
        };
        publish(this.messageContext, COUNT_UPDATED_CHANNEL, action);
    }

}