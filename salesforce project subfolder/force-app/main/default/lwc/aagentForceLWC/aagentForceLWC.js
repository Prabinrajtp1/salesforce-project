import { LightningElement,api } from 'lwc';

export default class AagentForceLWC extends LightningElement {

    @api name;
    @api email;
    @api phone;
    @api accountName;
}