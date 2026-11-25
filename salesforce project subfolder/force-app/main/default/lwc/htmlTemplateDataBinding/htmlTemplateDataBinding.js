import { LightningElement } from 'lwc';

export default class HtmlTemplateDataBinding extends LightningElement {
    name = 'Prabin';

    handleClick(event) {
        this.name = this.template.querySelector('lightning-input.inputclass').value;
    }
}