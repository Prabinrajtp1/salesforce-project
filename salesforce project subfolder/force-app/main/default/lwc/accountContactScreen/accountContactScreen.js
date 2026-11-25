import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getContactDetails from '@salesforce/apex/AccountContactHandler.getContactDetails';

const FIELDS = [
    'Account.Name',
    'Account.Phone',
    'Account.Industry',
    'Account.BillingCity'
];

export default class AccountContactScreen extends LightningElement {

    @api recordId;

    // Account Data

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    account;

    get accountName() {
        return this.account.data?.fields.Name.value;
    }

    get accountPhone() {
        return this.account.data?.fields.Phone.value;
    }

    get accountIndustry() {
        return this.account.data?.fields.Industry.value;
    }

    get accountBillingCity(){
        return this.account.data?.fields.BillingCity.value;
    }

    // Contact Data

    contacts = [];
    error;

    @wire(getContactDetails, { accountId: '$recordId' })
    wiredcontacts({ data, error }) {
        if (data) {
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.contacts = [];
        }
    }

    get hasContacts() {
        return this.contacts && this.contacts.length > 0;
    }
}