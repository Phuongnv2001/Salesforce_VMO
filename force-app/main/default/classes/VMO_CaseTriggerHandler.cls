/* Project Base VMO
 * Created Date: 03/08/2023
 * Created By: PhuongNV
 * Descript: Class handler for Case trigger
 * PIC: PhuongNV
 */
public with sharing class VMO_CaseTriggerHandler {

  @AuraEnabled(cacheable=true)
    public static Integer TotalTickets() {
        return [SELECT COUNT() FROM Case];
    }
    
    @AuraEnabled(cacheable=true)
    public static Integer TotalThisMonth() {
        Date thisMonthStart = Date.today().toStartOfMonth();
        Date thisMonthEnd = Date.today();
        return [SELECT COUNT() FROM Case WHERE CreatedDate >= :thisMonthStart AND CreatedDate <= :thisMonthEnd];
    }
    
    @AuraEnabled(cacheable=true)
    public static Integer TotalOpen() {
        return [SELECT COUNT() FROM Case WHERE Status = 'New'];
    }
    
    @AuraEnabled(cacheable=true)
    public static Integer TotalProcessing() {
        return [SELECT COUNT() FROM Case WHERE Status != 'New' AND IsClosed = false];
    }
    
    @AuraEnabled(cacheable=true)
    public static Integer TotalClosed() {
        return [SELECT COUNT() FROM Case WHERE IsClosed = true];
    }






  private static Boolean checkActive = true;
   // Handler before Update functions --
  public static void onBeforeUpdate(List<Case> newList, Map<Id, Case> oldMap) {
    if (checkActive == true) {
      checkSubjectUpdate(newList, oldMap);
    }
   }
   public static void onAfterUpdate(List<Case> newList, Map<Id,Case> oldMap){
    createTicketHandler(newList,oldMap);
	} 
   // Handler before Insert functions --
  public static void onBeforeInsert(List<Case> newList) {
   checkSubject(newList);
  }
    // Handler after Insert functions
  public static void onAfterInsert(List<Case> newList) {
    completeSubject(newList);
  }
  // Handler Case number and Subject functions
  private static void completeSubject(List<Case> targetRecs) {
    List<Case> casesToUpdate = new List<Case>();
    for (Case c : targetRecs) {
      Case updatedCase = new Case(
        Id = c.Id,
        Subject = '[' + c.CaseNumber + '] ' + c.Subject
      );
      casesToUpdate.add(updatedCase);
    }
    checkActive = false;
    update casesToUpdate;
  }
  // Handler update field functions
  private static void checkSubjectUpdate(
    List<Case> newList,
    Map<Id, Case> oldMap
  ) {
    for (Case c : newList) {
      if (c.Subject != oldMap.get(c.Id).Subject ) {
        c.addError(VMO_CommonConstant.UPDATE_SUBJECT_FALSE);
      }
    }
  }
  // Handler insert empty subject field functions
  private static void checkSubject(List<Case> newList) {
     for (Case c : newList) {
      if (String.isBlank(c.Subject)) {
        c.addError(VMO_CommonConstant.SUBEJCT_FALSE);
      }
    }
  }
  private static void createTicketHandler(List<Case> newCases, Map<Id, Case> oldCaseMap){
    List<VMO_TicketHistory__c> ticketHandlers = new List<VMO_TicketHistory__c>();
    List<Case> casesToUpdate = new List<Case>();
    List<String> all = new List<String>();
    for (Case newCase : newCases) {
    Case oldCase = oldCaseMap.get(newCase.Id);
    if (newCase.VMO_TicketHandler__c != oldCase.VMO_TicketHandler__c) {
      all.add(oldCase.VMO_TicketHandler__c);
      all.add(newCase.VMO_TicketHandler__c);
    }
   
	}
      
    List<User> users = [SELECT Id, Name FROM User WHERE Id IN :all];
       for (Case newCase : newCases) {
           Case oldCase = oldCaseMap.get(newCase.Id);
           if (newCase.Status != oldCase.Status) {
               createTicketHistoryRecord(ticketHandlers, newCase, oldCase, 'Status', newCase.Status, oldCase.Status);
           }
           if (newCase.OwnerId != oldCase.OwnerId) {
               createTicketHistoryRecord(ticketHandlers, newCase, oldCase, 'Owner Id', newCase.OwnerId, oldCase.OwnerId);
           }
           if (newCase.VMO_Answer__c != oldCase.VMO_Answer__c) {
               createTicketHistoryRecord(ticketHandlers, newCase, oldCase, 'Answer', newCase.VMO_Answer__c, oldCase.VMO_Answer__c);
           }
            Map<Id, User> userMap = new Map<Id, User>();
           for (User u : users) {
              userMap.put(u.Id, u);
               System.debug('test' +userMap.put(u.Id, u));
           }
           if (newCase != null && oldCase != null) {
               System.debug('test case old new '+newCase + oldCase);
  		  if (newCase.VMO_TicketHandler__c != oldCase.VMO_TicketHandler__c) {
              System.debug('test case ticket'+newCase.VMO_TicketHandler__c);
      	  User newTicketHandler = userMap.get(newCase.VMO_TicketHandler__c);
        	User oldTicketHandler = userMap.get(oldCase.VMO_TicketHandler__c);
       
            createTicketHistoryRecord(ticketHandlers, newCase, oldCase, 'Ticket Handler', newTicketHandler?.Name, oldTicketHandler?.Name);
        
           }

         }
        }
       if (!ticketHandlers.isEmpty()) {
           insert ticketHandlers;
      }
    }
  private static void createTicketHistoryRecord(
       List<VMO_TicketHistory__c> ticketHandlers,
       Case currentCase,
       Case oldCase,
       String fieldName,
       Object newValue,
       Object oldValue
   ) {
       VMO_TicketHistory__c ticketHistory = new VMO_TicketHistory__c();
       ticketHistory.Field_Name__c = fieldName;
       ticketHistory.New_Value__c = String.valueOf(newValue);
       ticketHistory.Old_Value__c = String.valueOf(oldValue);
       ticketHistory.VMO_ChangedTime__c = DateTime.now();
       ticketHistory.VMO_RelatedTicke__c = currentCase.Id;
       ticketHistory.VMO_ChangedUser__c = currentCase.LastModifiedById;
       
       ticketHandlers.add(ticketHistory);
       
   }        
}