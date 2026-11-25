import { LightningElement, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import comreo from '@salesforce/messageChannel/comreo__c';
export default class PublisherComponent extends LightningElement {
    firstName = '';
    lastName = '';

    @wire(MessageContext) messageContext;

    handleChangeFirstName(event) {
        this.firstName = event.target.value;
    }
    handleChangeLastName(event) {
        this.lastName = event.target.value;
    }

    handleClick(event) {

        //Pass details into subscriber component

        let payload = { firstname: this.firstName, lastname: this.lastName };
        publish(this.messageContext, comreo, payload)


    }
}