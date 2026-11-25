import { LightningElement, wire, api } from 'lwc';
import { MessageContext, subscribe, unsubscribe } from 'lightning/messageService';
import lwcproject from '@salesforce/messageChannel/lwcproject__c';
import getAccountContacts from '@salesforce/apex/AccountHandlerLWC.getAccountContacts';
import LightningConfirm from 'lightning/confirm';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';







export default class ShowAccountContacts extends LightningElement {
    subscription = null;
    @wire(MessageContext) messageContext;
    accountId;
    accountName;
    contacts;
    hasContacts;
    isAccountSelected = false;
    isAddContactClick = false;
    isEditClick = false;
    @api recordId;
    editableContactId;

    connectedCallback() {

        this.handleSubscribe();

    }

    disconnectedCallback() {

        this.handleUnsubscribe();
    }

    handleSubscribe() {

        if (!this.subscription) {
            this.subscription = subscribe(this.messageContext, lwcproject,
                (parameter) => {
                    this.accountId = parameter.accountId;
                    this.accountName = parameter.accountName;
                    this.title = this.accountName + "'s Contacts";
                    this.getContacts();

                }
            );
        }
    }


    async getContacts() {
        this.contacts = await getAccountContacts({ accountId: this.accountId });
        this.hasContacts = this.contacts.length > 0 ? true : false;
        this.isAccountSelected = true;
    }



    handleUnsubscribe() {
        unsubscribe(this.subscription);
        this.subscription = null;
    }


    handleAddContact(event) {
        this.isAddContactClick = true;

    }

    handleAddContactCancel(event) {
        this.isAddContactClick = false;

    }



    handleEditClick(event) {
        this.isEditClick = true;
        this.editableContactId = event.target.dataset.contactId;

    }

    handleEditCancel(event) {
        this.isEditClick = false;

    }

    handleSuccess(event) {
        this.isAddContactClick = false;
        this.isEditClick = false;
        this.getContacts();


    }


    async handleDelete(event) {
        this.editableContactId = event.target.dataset.contactId;

        const result = await LightningConfirm.open({
            message: 'Are you sure you want delete contact?',
            variant: 'headerless',
            label: 'this is the aria-label value',
            // setting theme would have no effect
        });
        if (result) {
            let deleteResult = await deleteRecord(this.editableContactId);
            this.getContacts();
            this.showSuccessToast();

        }

    }

    showSuccessToast() {
        const event = new ShowToastEvent({
            title: 'Success!',
            message: 'The record has been deleted successfully.',
            variant: 'success', // Options: 'success', 'error', 'warning', 'info'
            mode: 'dismissible' // Options: 'dismissible', 'sticky'
        });
        this.dispatchEvent(event);
    }







}