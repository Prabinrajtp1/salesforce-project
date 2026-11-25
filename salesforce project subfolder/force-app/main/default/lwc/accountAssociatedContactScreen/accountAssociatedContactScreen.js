import { LightningElement, api, wire } from 'lwc';
import getContacts from '@salesforce/apex/AccountContactController.getContacts';
const COLUMNS = [
    {
        label: 'Contact Name',
        fieldName: 'Name'
    },
    {
        label: 'Contact Email',
        fieldName: 'Email',
        type: 'email'
    },
    {
        label: 'Contact Phone',
        fieldName: 'Phone',
        type: 'Phone'
    }

]

export default class AccountAssociatedContactScreen extends LightningElement {

    @api recordId;
    error;
    columns = COLUMNS;
    contacts = [];

    @wire(getContacts, { accountId: '$recordId' })
    wiredcontacts({ data, error }) {

        if (data) {

            this.contacts = data;
            this.error = undefined;
        }
        else if (error) {
            this.error = error;
            this.data = undefined;
        }

    }

}