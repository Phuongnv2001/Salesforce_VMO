public with sharing class VMO_CaseDao {
    public VMO_CaseDao() {

    }
    public static Integer TotalTicketsCases() {
        return [SELECT COUNT() FROM Case];
    }
    public static Integer TotalThisMonthCases() {
        Date thisMonthStart = Date.today().toStartOfMonth();
        Date thisMonthEnd = Date.today();
        return [SELECT COUNT() FROM Case WHERE CreatedDate >= :thisMonthStart AND CreatedDate <= :thisMonthEnd];
    }
    public static Integer TotalOpenCases() {
        return [SELECT COUNT() FROM Case WHERE Status = 'New'];
    }
    public static Integer TotalProcessingCases() {
        return [SELECT COUNT() FROM Case WHERE Status != 'New' AND IsClosed = false];
    }
    public static Integer TotalClosedCases() {
        return [SELECT COUNT() FROM Case WHERE IsClosed = true];
    }
}