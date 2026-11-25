import { LightningElement ,api,wire} from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';

const Fields = ['Account.Name', 'Account.Phone', 'Account.Website','Account.Industry','Account.BillingCity'];

export default class AccountDetailDisplay extends LightningElement {

    @api recordId;// this is the only thing flow need to pass

    @wire(getRecord, { recordId: '$recordId', fields: Fields })
    account;

     get accountName() {
        return this.account.data?.fields.Name.value;
    }
    get phone() {
        return this.account.data?.fields.Phone.value;
    }
    get industry() {
        return this.account.data?.fields.Industry.value;
    }
    get billingCity() {
        return this.account.data?.fields.BillingCity.value;
    }
    
}