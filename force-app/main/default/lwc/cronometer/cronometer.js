import { LightningElement, track, api } from 'lwc';

export default class Cronometer extends LightningElement {
    @track timeCronometer = '0:0:0:0';
    timeIntervalInstance;
    totalMilliseconds = 0;

    handleCommand(event){
        const command = event.target.dataset.command;
        if (command == 'play') {
            this.play();            
        } else if(command=='stop') {
            this.stop();
        } else if(command=='reset'){
            this.reset();
        }        
    }

    play(){        
        var parentThis = this;

        // Run timer code in every 100 milliseconds
        this.timeIntervalInstance = setInterval(function() {

            // Time calculations for hours, minutes, seconds and milliseconds
            var hours = Math.floor((parentThis.totalMilliseconds % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((parentThis.totalMilliseconds % (1000 * 60 * 60)) / (1000 * 60));
            var seconds = Math.floor((parentThis.totalMilliseconds % (1000 * 60)) / 1000);
            var milliseconds = Math.floor((parentThis.totalMilliseconds % (1000)));
            
            // Output the result in the timeCronometer variable
            parentThis.timeCronometer = hours + ":" + minutes + ":" + seconds + ":" + milliseconds;   
            
            parentThis.totalMilliseconds += 100;
        }, 100);
    }

    stop(){
        clearInterval(this.timeIntervalInstance);
    }

    reset(){
        this.timeCronometer = '0:0:0:0';
        this.totalMilliseconds = 0;
        clearInterval(this.timeIntervalInstance);
    }

}