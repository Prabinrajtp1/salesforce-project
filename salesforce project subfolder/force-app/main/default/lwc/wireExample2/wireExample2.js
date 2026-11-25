import { LightningElement, api, wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
export default class WireExample2 extends LightningElement {

    @api recordId;

    @wire(getRecord, { recordId: "$recordId", fields: ['Contact.Name', 'Contact.Phone', 'Contact.Email'] })
    contacts;
    get getName() {
        if (this.contacts.data)
            return getFieldValue(this.contacts.data, 'Contact.Name');
        else if (this.contacts.error)
            return this.contacts.error;
    }
    get getPhone() {
        if (this.contacts.data)
            return getFieldValue(this.contacts.data, 'Contact.Phone');
        else if (this.contacts.error)
            return this.contacts.error;
    }
    get getEmail() {
        if (this.contacts.data)
            return getFieldValue(this.contacts.data, 'Contact.Email');
        else if (this.contacts.error)
            return this.contacts.error;
    }


}