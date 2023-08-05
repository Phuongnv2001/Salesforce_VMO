/* Project Base VMO
 * Created Date: 03/08/2023
 * Created By: PhuongNV
 * Descript: Class handler for Case trigger
 * PIC: PhuongNV
 */
public with sharing class VMO_CaseTriggerHandler {
  private static Boolean checkActive = true;
   // Handler before Update functions --
  public static void onBeforeUpdate(List<Case> newList, Map<Id, Case> oldMap) {
    if (checkActive == true) {
      checkSubjectUpdate(newList, oldMap);
    }
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
  // tạo bản ghi ở TicketHandler khi update case 
  private static void createTicketHandler(List<Case> newCases, Map<Id, Case> oldCaseMap){
    List<VMO_TicketHistory__c> ticketHandlers = new List<VMO_TicketHistory__c>();
    for (Case c : newCases){
      Case oldCase = oldCaseMap.get(c.Id);
      // nếu thay đổi Status thì sẽ add một bản ghi của Status vào list ticketHandlers
      if (c.Status != oldCase.Status){
        VMO_TicketHistory__c th = new VMO_TicketHistory__c();
        th.Field_Name__c = 'Status';
        th.New_Value__c = c.Status;
        th.Old_Value__c = oldCaseMap.get(c.Id).Status;
        th.VMO_ChangedTime__c = DateTime.now();
        th.VMO_RelatedTicke__c = c.Id;
        th.VMO_ChangedUser__c = c.LastModifiedById;
        ticketHandlers.add(th);
      }
      // nếu thay đổi OwnerId thì sẽ add một bản ghi của OwnerId vào list ticketHandlers
       if (c.OwnerId != oldCase.OwnerId){
        VMO_TicketHistory__c th = new VMO_TicketHistory__c();
        th.Field_Name__c = 'Owner Id';
        th.New_Value__c = c.Status;
        th.Old_Value__c = oldCaseMap.get(c.Id).Status;
        th.VMO_ChangedTime__c = DateTime.now();
        th.VMO_RelatedTicke__c = c.Id;
        th.VMO_ChangedUser__c = c.LastModifiedById;
        ticketHandlers.add(th);
      }
       // nếu thay đổi Answer thì sẽ add một bản ghi của Answer vào list ticketHandlers
     if (c.VMO_Answer__c != oldCase.VMO_Answer__c){
        VMO_TicketHistory__c th = new VMO_TicketHistory__c();
        th.Field_Name__c = 'Answer';
        th.New_Value__c = c.Status;
        th.Old_Value__c = oldCaseMap.get(c.Id).Status;
        th.VMO_ChangedTime__c = DateTime.now();
        th.VMO_RelatedTicke__c = c.Id;
        th.VMO_ChangedUser__c = c.LastModifiedById;
        ticketHandlers.add(th);
      }
      // nếu thay đổi TicketHandler thì sẽ add một bản ghi của TicketHandler vào list ticketHandlers
      if (c.VMO_TicketHandler__c != oldCase.VMO_TicketHandler__c){
        VMO_TicketHistory__c th = new VMO_TicketHistory__c();
        th.Field_Name__c = 'Ticket Handler';
        th.New_Value__c = c.Status;
        th.Old_Value__c = oldCaseMap.get(c.Id).Status;
        th.VMO_ChangedTime__c = DateTime.now();
        th.VMO_RelatedTicke__c = c.Id;
        th.VMO_ChangedUser__c = c.LastModifiedById;
        ticketHandlers.add(th);
      }
    }
    //nếu ticketHandlers mà bằng null thì sẽ không tạo ra bản ghi nào còn nếu khác null sẽ tạo ra bản ghi mới 
      if (!ticketHandlers.isEmpty()) {
        // tạo mới bản ghi có trong list ticketHandlers và lưu vào database 
        insert ticketHandlers;
    }
  }
}
