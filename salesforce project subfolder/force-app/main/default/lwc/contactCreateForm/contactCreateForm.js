import { LightningElement, api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class ContactCreateForm extends LightningElement {
    @api recordId;

    handleSubmit(event) {
        // Disabled fields are not submitted, so set AccountId explicitly
        event.preventDefault();
        const fields = event.detail.fields;
        fields.AccountId = this.recordId;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
    }

    handleSuccess(event) {

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Contact created successfully!',
                variant: 'success'
            })
        );

        // Reset the form
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );

        inputFields.forEach(field => {
            field.reset();
        });
    }

    handleErrors(event) {

        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: event.detail.message,
                variant: 'error'
            })
        );
    }

}