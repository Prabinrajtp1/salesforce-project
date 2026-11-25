import { LightningElement, api, wire } from 'lwc';
import { publish, MessageContext } from 'lightning/messageService';
import lwcproject from '@salesforce/messageChannel/lwcproject__c';
import getAccounts from '@salesforce/apex/AccountHandlerLWC.getAccounts';

export default class AccountChild2 extends LightningElement {
    @api searchTextChild2;
    @wire(MessageContext) messageContext;


    columns = [
        { label: 'ID', fieldName: 'Id' },
        { label: 'Name', fieldName: 'Name' },
        {
            label: 'Actions', fieldName: 'Actions', type: 'button', typeAttributes:
            {
                label: 'View Contacts',
                value: 'view_contact'
            }
        }
    ]

    rows = [

        { Id: '1', Name: 'Prabinraj' },
        { Id: '2', Name: 'Yadu' },
        { Id: '3', Name: 'Sreejith' },
        { Id: '4', Name: 'Sreeshma' },
        { Id: '5', Name: 'Sayoojya' },



    ]

    currentId;
    currentName;

    handleRowAction(event) {
        if (event.detail.action.value == 'view_contact') {
            this.currentId = event.detail.row.Id;
            this.currentName = event.detail.row.Name;


            //Pass details into Unrelted component component

            let payload = { accountId: event.detail.row.Id, accountName: event.detail.row.Name };
            publish(this.messageContext, lwcproject, payload)

        }
    }


    @wire(getAccounts, { searchText: '$searchTextChild2' }) accountRecords;
}