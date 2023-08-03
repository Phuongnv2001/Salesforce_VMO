/*Project Base VMO
* Created Date: 24/07/2023
* Created By: LocHN
* Descript: Data Access Object to query from RecordType Object
* PIC: LocHN
*/
public class VMO_RecordTypeDAO {
    public static List<RecordType> getRecordTypeListByObjName(String objName) {
        if(String.isBlank(objName)) {
            return new List<RecordType>();
        }
        List<RecordType> recordTypeLs = [SELECT Id, 
                Name
                FROM RecordType 
                WHERE IsActive = true 
                AND SobjectType =: objName];
        return recordTypeLs.size() > 0 ? recordTypeLs : new List<RecordType>();
    }
}