import { LightningElement, api } from 'lwc';
import { FlowAttributeChangeEvent } from 'lightning/flowSupport';
export default class LwcToFlow extends LightningElement {

    @api accountName;
    inputdata;
    handleChange(event) {

        this.inputdata = event.target.value;

        const attributeChangeEvent = new FlowAttributeChangeEvent('accountName', this.inputdata);

        this.dispatchEvent(attributeChangeEvent);


    }
}