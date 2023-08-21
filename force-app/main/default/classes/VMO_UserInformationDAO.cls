public with sharing class VMO_UserInformationDAO {
    public VMO_UserInformationDAO() {
        
    }
     public static List<User> GetUsersWithInfo() {
        return [SELECT FullPhotoUrl,email,Name,employee_code__c,Date_Of_Birth__c FROM User where employee_code__c = 1936];
    }
   public static List<String> getTicketTypeOptions() {
        List<String> options = new List<String>();
        List<AggregateResult> results = [SELECT VMO_TicketHandler__c, COUNT(Id) FROM Case GROUP BY VMO_TicketHandler__c];
        for (AggregateResult result : results) {
            String ticketType = (String) result.get('VMO_TicketHandler__c');
            options.add(ticketType);
        }
        return options;
    }

    public static List<String> getCategoryOptions() {
        List<String> options = new List<String>();
        List<AggregateResult> results = [SELECT Category__c, COUNT(Id) FROM Case GROUP BY Category__c];
        for (AggregateResult result : results) {
            String category = (String) result.get('Category__c');
            options.add(category);
        }
        return options;
    }

    public static List<String> getStatusOptions() {
        List<String> options = new List<String>();
        List<AggregateResult> results = [SELECT Status, COUNT(Id) FROM Case GROUP BY Status];
        for (AggregateResult result : results) {
            String status = (String) result.get('Status');
            options.add(status);
        }
        return options;
    }
}