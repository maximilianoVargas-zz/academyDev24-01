import { LightningElement, api } from 'lwc';

export default class ChronometerTimer extends LightningElement {

    @api timer;

    get getTime() {
        let date = new Date(this.timer);
        return `${date.getHours()} : ${date.getMinutes()} : ${date.getSeconds()} : ${date.getMilliseconds()}`;
    }
}