/* Project Base VMO
 * Created Date: 24/07/2023
 * Created By: LocHN
 * Descript: Server controller(APEX) for LWC
 * PIC: LocHN
*/
public with sharing class VMO_LWCController {
    public VMO_LWCController() {
        // get list ticket type avaiable
        @AuraEnabled(cacheable=true)
        public static User getListTicketType() {
            return VMO_CommonUtils.getTicketTypeList();
        }
        // function to create new tickwt from lwc
        @AuraEnabled()
        public static TicketResults createTicket(Id recId, String inputSubject, String inputCategory, String inputDes) {
        Case newCase = new Case();
        newCase.Subject = inputSubject;
        newCase.VMO_Category__c = inputCategory;
        newCase.VMO_Department__c = [SELECT Name FROM RecordType WHERE Id =: recId]?.Name;
        newCase.Description = inputDes;
        newCase.RecordTypeId = recId;

        try {
            insert newCase;
            return new TicketResults(true, VMO_CommonConstant.CREATETICKET_SUCCESS , newCase.Id);
        } catch (Exception e) {
            return new TicketResults(false, VMO_CommonConstant.CREATETICKET_FALSE + e.getMessage());
        }
    }
}