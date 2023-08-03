/* Project Base VMO
 * Created Date: 24/07/2023
 * Created By: LocHN
 * Descript: Common functions for reuse
 * PIC: LocHN
*/
public with sharing class VMO_CommonUtils {
    public VMO_CommonUtils() {
        public static List<RecordType> getTicketTypeList() {
            return VMO_RecordTypeDAO.getRecordTypeListByObjName('Case');
        }
    }
}