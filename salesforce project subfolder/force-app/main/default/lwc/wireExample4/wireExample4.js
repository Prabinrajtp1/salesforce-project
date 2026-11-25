import { getRecord } from 'lightning/uiRecordApi';
import { LightningElement, api, wire, track } from 'lwc';

export default class WireExample4 extends LightningElement {

    @api recordId;
    @track accounts;
    @track error;

    @wire(getRecord, { recordId: '$recordId', fields: ['Account.Name', 'Account.Phone', 'Account.Rating'] })
    wiredAccounts({ data, error }) {

        if (data) {
            this.accounts = data;
            this.error = undefined;
        }

        else if (error) {
            this.accounts = undefined;
            this.error = error;
        }

    }

    get getName() {

        return this.accounts.fields.Name.value;
    }
    get getPhone() {
        return this.accounts.fields.Phone.value;
    }

    get Rating() {
        return this.accounts.fields.Rating.value;
    }

}