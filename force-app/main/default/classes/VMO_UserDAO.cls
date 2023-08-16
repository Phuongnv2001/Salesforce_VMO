/* Project Base VMO
 * Created Date: 24/07/2023
 * Created By: LocHN
 * Descript: Data Access Object to query from User object
 * PIC: LocHN
*/
public with sharing class VMO_UserDAO {
    public VMO_UserDAO() {
        // get current user information
        public static Integer TotalTickets() {
            return [SELECT COUNT() FROM Case];
        }
    }
}