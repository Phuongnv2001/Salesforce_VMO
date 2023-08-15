import { LightningElement, wire } from 'lwc';
import getTotalTickets from '@salesforce/apex/VMO_CaseTriggerHandler.TotalTickets';
import getTotalThisMonth from '@salesforce/apex/VMO_CaseTriggerHandler.TotalThisMonth';
import getTotalOpen from '@salesforce/apex/VMO_CaseTriggerHandler.TotalOpen';
import getTotalProcessing from '@salesforce/apex/VMO_CaseTriggerHandler.TotalProcessing';
import getTotalClosed from '@salesforce/apex/VMO_CaseTriggerHandler.TotalClosed';

export default class Demo_Bai2 extends LightningElement {
    total_case;
    total_month;
    total_open;
    total_processing;
    total_closed;

    connectedCallback() {
        this.fetchUserData();
    }

    async fetchUserData() {
        this.total_case = await getTotalTickets();
        this.total_month = await getTotalThisMonth();
        this.total_open = await getTotalOpen();
        this.total_processing = await getTotalProcessing();
        this.total_closed = await getTotalClosed();
    }
}
