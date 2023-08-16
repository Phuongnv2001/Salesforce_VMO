import { LightningElement, wire } from 'lwc';
import getTotalTickets from '@salesforce/apex/VMO_SummaryCaseTriggerHandler.getTotalTickets';
import getTotalThisMonth from '@salesforce/apex/VMO_SummaryCaseTriggerHandler.getTotalThisMonth';
import getTotalOpen from '@salesforce/apex/VMO_SummaryCaseTriggerHandler.getTotalOpen';
import getTotalProcessing from '@salesforce/apex/VMO_SummaryCaseTriggerHandler.getTotalProcessing';
import getTotalClosed from '@salesforce/apex/VMO_SummaryCaseTriggerHandler.getTotalClosed';

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
        try {
            this.total_case = await getTotalTickets() || 0;
            this.total_month = await getTotalThisMonth() || 0;
            this.total_open = await getTotalOpen() || 0;
            this.total_processing = await getTotalProcessing() || 0;
            this.total_closed = await getTotalClosed() || 0;
        } catch (error) {
            console.error('An error occurred:', error);
        }
    }
}
