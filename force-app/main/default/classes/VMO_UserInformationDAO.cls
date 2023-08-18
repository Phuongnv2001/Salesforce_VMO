public with sharing class VMO_UserInformationDAO {
    public VMO_UserInformationDAO() {
        
    }
     public static List<User> GetUsersWithInfo() {
        return [SELECT FullPhotoUrl,email,Name,employee_code__c,Date_Of_Birth__c FROM User where employee_code__c = 1936];
    }
}