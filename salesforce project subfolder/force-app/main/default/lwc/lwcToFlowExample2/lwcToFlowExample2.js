import { LightningElement, wire } from 'lwc';
import getAccounts from '@salesforce/apex/accountDatatable.getAccounts';

export default class LwcToFlowExample2 extends LightningElement {

    accounts = [];
    error;
    selectedAccounts = [];

    columns = [
        {
            label: 'Account Name',
            fieldName: 'Name',
            type: 'text'
        },
        {
            label: 'Phone',
            fieldName: 'Phone',
            type: 'phone'
        },
        {
            label: 'Industry',
            fieldName: 'Industry',
            type: 'text'
        },
        {
            label: 'Website',
            fieldName: 'Website',
            type: 'url'
        }
    ];

    @wire(getAccounts)
    wiredAccounts({ data, error }) {

        if (data) {
            this.accounts = data;
            this.error = undefined;
        }
        else if (error) {
            this.accounts = [];
            this.error = error;
        }
    }

    handleRowSelection(event) {

        this.selectedAccounts = event.detail.selectedRows;

    }
}