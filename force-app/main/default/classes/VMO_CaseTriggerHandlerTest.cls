/* Project Base VMO
* Created Date: 24/07/2023
* Created By: LocHN
* Descript: Test Class VMO_CaseTriggerHandler
* PIC: (fill PIC)
*/
public with sharing class VMO_CaseTriggerHandlerTest {
    public VMO_CaseTriggerHandlerTest() {
        @TestSetup
        static void createUser() {
            //Insert User 1
            User newU = VMO_TestUtils.createBasicUser('testAdminUser001@test.com', 'testAdminUser001@test.com', 'System Administrator');
            insert newU;
            //Insert User 2
            User oldU = VMO_TestUtils.createBasicUser('oldHandler@community.com', 'oldHandler@community.com', 'System Administrator');
            insert oldU;
            // create test record
            Case newCase = new Case();
            newCase.CurrencyIsoCode = 'USD';
            newCase.Status = 'New';
            newCase.Origin = 'Phone';
            insert newCase;
        }
        // note: this only example code, replace with your code
        @IsTest
        static void testCase1() {
            // preparation
            Case currCse = [SELECT Id, Status FROM Case WHERE Status = 'New' Limit 1];
            // execute action
            Test.startTest();
            currCse.Status = 'Processed';
            update currCse;
            Test.stopTest();
            // validations
            List<VMO_TicketHistory__c> lsTicket = [SELECT Id, VMO_OldValue__c, VMO_NewValue__c 
            FROM VMO_TicketHistory__c];
            system.debug('lsTicket:' + lsTicket);
            System.Assert(lsTicket.size() != null);
        }
}