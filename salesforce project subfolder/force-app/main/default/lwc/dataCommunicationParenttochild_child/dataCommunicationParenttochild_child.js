import { LightningElement, api } from 'lwc';

export default class DataCommunicationParenttochild_child extends LightningElement {
    @api fName;
    @api lName;

    handleClick(event) {
        const inputs = this.template.querySelectorAll('lightning-input');
        inputs.forEach(element => {

            if (element.name == "firstname") {
                this.fName = element.value;
            }
            else if (element.name == "lastname") {
                this.lName = element.value;
            }
        });
        const searchEvent = new CustomEvent('getsearchevent', {
            detail:
            {
                FirstName: this.fName,
                LastName: this.lName
            }
        });
        this.dispatchEvent(searchEvent);
    }

}