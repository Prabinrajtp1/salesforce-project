import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


export default class AccountUpdateForm extends LightningElement {

    @api recordId;

    handlesuccess(event) {
        this.dispatchEvent(new ShowToastEvent({ title: 'Success', message: 'Account record Created Successfully', variant: 'success' })
        );


    }

    handleerror(event) {
        this.dispatchEvent(new ShowToastEvent({ title: 'error', message: 'An error occured', variant: 'error' }));

    }
}