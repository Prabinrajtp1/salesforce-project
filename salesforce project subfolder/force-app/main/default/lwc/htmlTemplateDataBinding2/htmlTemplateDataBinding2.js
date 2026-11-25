import { LightningElement } from 'lwc';

export default class HtmlTemplateDataBinding2 extends LightningElement {
    fName;
    lName;

    handleClick(event) {
        const inputs = this.template.querySelectorAll('lightning-input');

        inputs.forEach((element) => {
            if (element.name === 'firstName') {
                this.fName = element.value;
            } else if (element.name === 'lastName') {
                this.lName = element.value;
            }
        });


    }
}