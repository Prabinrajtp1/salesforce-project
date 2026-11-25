import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
import getContacts from '@salesforce/apex/accountContactDatatableController.getContacts';
import deleteContacts from '@salesforce/apex/accountContactDatatableController.deleteContacts';
import { refreshApex } from '@salesforce/apex';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const COLUMNS = [

    {
        label: 'Contact Name',
        fieldName: 'Name'
    },

    {
        label: 'Contact Phone',
        fieldName: 'Phone',
        type: 'Phone'
    },

    {
        label: 'Contact Email',
        fieldName: 'Email',
        type: 'Email'

    }

]

const FIELDS = [
    'Account.Name',
    'Account.Phone',
    'Account.Industry',
    'Account.Rating'
];

export default class AccountWithContactDatatable extends LightningElement {

    @api recordId;
    accounterror;


    @wire(getRecord, { recordId: '$recordId', fields: FIELDS })
    account;


    get getName() {
        return this.account.data?.fields.Name.value;

    }
    get getPhone() {
        return this.account.data?.fields.Phone.value;
    }
    get getIndustry() {
        return this.account.data?.fields.Industry.value;
    }
    get getRating() {

        return this.account.data?.fields.Rating.value;
    }
    columns = COLUMNS;
    contacts = [];
    selectedRows = [];
    error;
    wiredContactsResult;

    @wire(getContacts, { accountId: '$recordId' })
    wiredcontacts(result) {

        this.wiredContactsResult = result;

        const { data, error } = result;

        if (data) {
            this.contacts = data;
            this.error = undefined;
        } else if (error) {
            this.contacts = [];
            this.error = error;
        }
    }

    handleRowSelection(event) {
        this.selectedRows = event.detail.selectedRows;
    }
    get disableDelete() {
        return this.selectedRows.length === 0;
    }
    async handleDelete() {

        const recordIds = this.selectedRows.map(row => row.Id);

        try {

            await deleteContacts({
                contactIds: recordIds
            });

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Selected contacts deleted successfully',
                    variant: 'success'
                })
            );

            this.selectedRows = [];

            await refreshApex(this.wiredContactsResult);

        } catch (error) {

            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error',
                    message: error.body?.message || 'Error deleting records',
                    variant: 'error'
                })
            );
        }
    }


}