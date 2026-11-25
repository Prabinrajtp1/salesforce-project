import { LightningElement, wire } from 'lwc';
import getRelatedTaskDetails from '@salesforce/apex/ContactTaskController.getRelatedTaskDetails';

export default class ContactWithRelatedTasks extends LightningElement {

    contacts;
    error;

    @wire(getRelatedTaskDetails)
    wiredContacts({ data, error }) {
        if (data) {
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contacts = undefined;
        }
    }

    get hasContacts() {
        return this.contacts && this.contacts.length > 0;
    }
}