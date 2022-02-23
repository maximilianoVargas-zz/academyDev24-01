import { LightningElement } from 'lwc';

export default class Cronometer extends LightningElement {
    horas = 0;
    minutos = 0;
    segundos = 0;
    dhoras = '0';
    dminutos = '0';
    dsegundos = '0';
    timer;
    thereArePlay = false;

    handleClick(event){
        const factor = event.detail;
        if(factor=='play' && !this.thereArePlay){
            this.template.querySelector('.cronometer-display').style='background-color:green';
            this.thereArePlay = true;
            this.timer = setInterval(() => {                
                if(this.segundos==59){
                    if(this.minutos==59){
                        if(this.horas==99){
                            this.segundos=0;
                            this.dsegundos='0';
                            this.minutos=0;
                            this.dminutos='0';
                            this.horas=0;
                            this.dhoras='0';
                        } else {
                            this.segundos=0;
                            this.dsegundos='0';
                            this.minutos=0;
                            this.dminutos='0';
                            this.horas++;
                            if(this.horas==10){
                                this.dhoras='';
                            }
                        }
                    } else {
                        this.segundos=0;
                        this.dsegundos='0';
                        this.minutos++;
                        if(this.minutos==10){
                            this.dminutos='';
                        }
                    }
                } else {
                    this.segundos++;
                    if(this.segundos==10){
                        this.dsegundos='';
                    }
                }
            }, 1000);
        }
        if(factor=='pause' && this.thereArePlay){
            this.template.querySelector('.cronometer-display').style='background-color:red';
            this.thereArePlay = false;
            clearInterval(this.timer);
        }
        if(factor=='stop'){
            this.template.querySelector('.cronometer-display').style='background-color:#1798c1';
            this.thereArePlay = false;
            clearInterval(this.timer);
            this.segundos=0;
            this.dsegundos='0';
            this.minutos=0;
            this.dminutos='0';
            this.horas=0;
            this.dhoras='0';
        }
    }
}