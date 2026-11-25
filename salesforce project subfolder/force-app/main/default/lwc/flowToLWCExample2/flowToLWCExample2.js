import { LightningElement, api } from 'lwc';

export default class FlowToLWCExample2 extends LightningElement {

    @api accounts = [];

    COLUMNS = [
        {
            label: 'Account Name',
            fieldName: 'Name',
            type: 'text'

        },
        {
            label: 'Phone',
            fieldName: 'Phone',
            type: 'Phone'

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
    ]
}