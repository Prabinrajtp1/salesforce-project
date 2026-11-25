import { LightningElement, api } from 'lwc';

export default class SampleLwcToFlow extends LightningElement {

    @api amount;
    @api discount;
    @api finalAmount;
    errormsg;

    handleAmount(event) {
        this.amount = event.target.value;
        this.validate();
        this.calculate();
    }
    handleDiscount(event) {
        this.discount = event.target.value;
        this.validate();
        this.calculate();
    }

    calculate() {

        try {
            if (this.amount && this.discount) {

                this.finalAmount = this.amount - (this.amount * this.discount / 100);
            }
        }
        catch (error) {
            this.errormsg = error.message
        }
    }

    validate() {
        if (!this.amount || !this.discount) {
            return {
                isValid: false,
                errorMessage: "Both fields are required"
            };
        }
        return { isValid: true };
    }
}