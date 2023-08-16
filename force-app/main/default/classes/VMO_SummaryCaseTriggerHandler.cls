public with sharing class VMO_SummaryCaseTriggerHandler {
    public VMO_SummaryCaseTriggerHandler() {

    }

    @AuraEnabled(cacheable=true)
    public static Integer getTotalTickets() {
        return VMO_CaseDao.TotalTicketsCases();
    }

    @AuraEnabled(cacheable=true)
    public static Integer getTotalThisMonth() {
        return VMO_CaseDao.TotalThisMonthCases();
    }

    @AuraEnabled(cacheable=true)
    public static Integer getTotalOpen() {
        return VMO_CaseDao.TotalOpenCases();
    }

    @AuraEnabled(cacheable=true)
    public static Integer getTotalProcessing() {
        return VMO_CaseDao.TotalProcessingCases();
    }

    @AuraEnabled(cacheable=true)
    public static Integer getTotalClosed() {
        return VMO_CaseDao.TotalClosedCases();
    }
}
