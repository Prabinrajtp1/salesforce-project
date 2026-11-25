import { LightningElement, wire, api } from 'lwc';
import getAccountDetails from '@salesforce/apex/AccountHandler.getAccountDetails';

export default class WireExample3 extends LightningElement {
    @api recordId;

    @wire(getAccountDetails, { accId: '$recordId' })
    accounts;
}