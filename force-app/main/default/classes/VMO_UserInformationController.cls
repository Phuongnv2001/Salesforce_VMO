public with sharing class VMO_UserInformationController {
     public VMO_UserInformationController() {

    }
    @AuraEnabled(cacheable=true)
    public static List<User> getUsersWithInfotoDao() {
        return VMO_UserInformationDAO.GetUsersWithInfo();
    }
    @AuraEnabled
    public static String logFieldChanges(String subject, String ticketType, String status, String category, String startDate, String endDate) {
        try {
            // Thực hiện việc ghi log, ví dụ như insert vào đối tượng Log_Field_Changes__c
            // Hoặc bạn có thể sử dụng System.debug để ghi log vào Debug Logs
            System.debug('Subject changed to: ' + subject);
            System.debug('Ticket Type changed to: ' + ticketType);
            System.debug('Status changed to: ' + status);
            System.debug('Category changed to: ' + category);
            System.debug('Start Date changed to: ' + startDate);
            System.debug('End Date changed to: ' + endDate);
            return 'Field changes logged successfully.';
        } catch (Exception ex) {
            return 'Error logging field changes: ' + ex.getMessage();
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<String> getTicketTypeOptions() {
        return VMO_UserInformationDAO.getTicketTypeOptions();
    }
    @AuraEnabled(cacheable=true)
    public static List<String> getCategoryOptions() {
        return VMO_UserInformationDAO.getCategoryOptions();
    }
    
    @AuraEnabled(cacheable=true)
    public static List<String> getStatusOptions() {
        return VMO_UserInformationDAO.getStatusOptions();
    }
}