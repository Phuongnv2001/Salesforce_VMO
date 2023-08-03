/* Project Base VMO
 * Created Date: 24/07/2023
 * Created By: LocHN
 * Descript: Client controller(js) for LWC
 * PIC: LocHN
*/
import { LightningElement, api } from 'lwc';
import { COMMON_VALUE } from './vmp_CaseView_AF_Const';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import createTicket from '@salesforce/apex/VMO_LWCController.createTicket';

export default class vmo_lwcdemo extends LightningElement {
    @api recordId;
    inputSubject = '';
    inputCategory ='';
    inputDes = '';
    connectedCallback() {
        console.log('connected callback');
    }

    async insertTicket() {
        const res = await createTicket({ recId: this.recordId, inputSubject: this.inputSubject, inputCategory: this.inputCategory, inputDes: this.inputDes });
        if (Object.keys(res).length) {
            this.showNotification(res.success, res.message);
        }
    }

    showNotification(isSuccess, message) {
        const evt = new ShowToastEvent({
            title: COMMON_VALUE.TICKET_CREATE_RESULT,
            message: message,
            variant: isSuccess ? COMMON_VALUE.TICKET_SUCCESS : COMMON_VALUE.TICKET_FAILURE,
        });
        this.dispatchEvent(evt);
    }
}