import { LightningElement } from 'lwc';

import sendTemplateMessage
    from '@salesforce/apex/WhatsAppService.sendTemplateMessage';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class WhatsappIntegration extends LightningElement {

    name = '';
    phoneNumber = '';
    orderNumber = '';
    orderDate = '';

    isLoading = false;

    handleName(event) {
        this.name = event.target.value;
    }

    handlePhone(event) {
        this.phoneNumber = event.target.value;
    }

    handleOrderNumber(event) {
        this.orderNumber = event.target.value;
    }

    handleDate(event) {
        this.orderDate = event.target.value;
    }

    async handleSend() {

        // Validate input fields
        if (
            !this.name ||
            !this.phoneNumber ||
            !this.orderNumber ||
            !this.orderDate
        ) {
            this.showToast(
                'Error',
                'Please enter all required details',
                'error'
            );
            return;
        }

        this.isLoading = true;

        try {

            // Call Apex method
            const response = await sendTemplateMessage({

                toPhone: this.phoneNumber,
                customerName: this.name,
                orderNumber: this.orderNumber,
                orderDate: this.orderDate

            });

            console.log('WhatsApp Response:', response);

            this.showToast(
                'Success',
                'WhatsApp message request submitted successfully!',
                'success'
            );

            // Clear input fields
            this.name = '';
            this.phoneNumber = '';
            this.orderNumber = '';
            this.orderDate = '';

        } catch (error) {

            console.error('WhatsApp Error:', error);

            this.showToast(
                'Error',
                error.body?.message || 'Failed to send WhatsApp message',
                'error'
            );

        } finally {

            this.isLoading = false;

        }
    }

    showToast(title, message, variant) {

        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        );

    }
}