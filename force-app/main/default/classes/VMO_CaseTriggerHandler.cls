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
  public static void createTicketHandler(List<Case> newCases, Map<Id, Case> oldCaseMap) {
        List<VMO_TicketHistory__c> ticketHandlers = new List<VMO_TicketHistory__c>();
        for (Case c : newCases) {
            Case oldCase = oldCaseMap.get(c.Id);
            if (c.Status != oldCase.Status || c.OwnerId != oldCase.OwnerId || c.VMO_Answer__c != oldCase.VMO_Answer__c ||c.VMO_TicketHandler__c != oldCase.VMO_TicketHandler__c ) {
                VMO_TicketHistory__c th = new VMO_TicketHistory__c();
                th.Field_Name__c = c.SuppliedCompany;
                th.Old_Value__c = c.Subject;
                ticketHandlers.add(th);
            }
          
        }
        if (!ticketHandlers.isEmpty()) {
            insert ticketHandlers;
        }
    }
}