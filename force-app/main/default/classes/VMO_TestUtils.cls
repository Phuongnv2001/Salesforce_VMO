public with sharing class VMO_TestUtils {
    public VMO_TestUtils() {
        public static User createBasicUser(String userName, String email, String profileName) {
            User rec = new User();
            rec.username = userName;
            rec.LastName = 'last name test';
            rec.FirstName = 'fisrt name test';
            rec.Email = email;
            rec.Alias = 'TestUser';
            rec.TimeZoneSidKey = 'Asia/Tokyo';
            rec.LocaleSidKey = 'ja_JP';
            rec.EmailEncodingKey = 'ISO-2022-JP';
            rec.LanguageLocaleKey = 'ja';
            rec.Extension = '080-9894-6868';
            rec.CompanyName = 'VMO Holdings';
            List<Profile> prof = [SELECT id from PROFILE where name = :profileName];
            rec.profileid = prof[0].id;
            rec.FederationIdentifier = 'fisrt name test';
            return rec;
        }
    }
}