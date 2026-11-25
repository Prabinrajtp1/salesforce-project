import { LightningElement, track } from 'lwc';

export default class TrackDecoratorExample extends LightningElement {

    @track count = 0;

    handleClick() {
        this.count++;
    }
    handleSubstract() {
        this.count--;
    }
}