import { LightningElement, wire } from 'lwc';
import getUsersWithInfotoDao from "@salesforce/apex/VMO_UserInformationController.getUsersWithInfotoDao";
import logFieldChanges from "@salesforce/apex/VMO_UserInformationController.logFieldChanges";

export default class Vmo_UserInformation extends LightningElement {
    userWithInfo = {};
    subjectValue = '';
    ticketTypeValue = '';
    statusValue = '';
    categoryValue = '';
    startDateValue = '';
    endDateValue = '';
    connectedCallback() {
        this.fetchUserWithInfo();
    }
     
    async fetchUserWithInfo() {
        try {
            const userList = await getUsersWithInfotoDao();
            if (userList.length > 0) {
                this.userWithInfo = userList[0];
                console.log("test du lieu", this.userWithInfo);
            }
           
        } catch (error) {
            console.error('An error occurred:', error);
        }
    }

    get employeeCode() {
        return this.userWithInfo.employee_code__c || '';
    }

    get userEmail() {
        return this.userWithInfo.Email || '';
    }

    get userDateOfBirth() {
        const fullDate = this.userWithInfo.Date_Of_Birth__c || '';
    if (fullDate) {
        return fullDate.split('T')[0];
    }
    return '';
    }
    get userName(){
        return this.userWithInfo.Name || '';
    }
    get userFullPhotoUrl(){
        return this.userWithInfo.FullPhotoUrl || '';
    }
    handleSubjectChange(event) {
        this.subjectValue = event.target.value;
    }

    handleTicketTypeChange(event) {
        this.ticketTypeValue = event.target.value;
    }

    handleStatusChange(event) {
        this.statusValue = event.target.value;
    }

    handleCategoryChange(event) {
        this.categoryValue = event.target.value;
    }

    handleStartDateChange(event) {
        this.startDateValue = event.target.value;
    }

    handleEndDateChange(event) {
        this.endDateValue = event.target.value;
    }

    async handleSearchClick() {
        try {
            const userList = await getUsersWithInfotoDao();
            if (userList.length > 0) {
                this.userWithInfo = userList[0];
                console.log("test du lieu", this.userWithInfo);
            }

            // Gọi hàm Apex để ghi log các giá trị
            logFieldChanges({
                subject: this.subjectValue,
                ticketType: this.ticketTypeValue,
                status: this.statusValue,
                category: this.categoryValue,
                startDate: this.startDateValue,
                endDate: this.endDateValue
            })
            .then(result => {
                console.log('Field changes logged:', result);
            })
            .catch(error => {
                console.error('Error logging field changes:', error);
            });

        } catch (error) {
            console.error('An error occurred:', error);
        }
    }
}
