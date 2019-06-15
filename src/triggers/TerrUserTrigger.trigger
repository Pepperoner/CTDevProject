/*
 * Created by Pepperoner on 01.04.2019.
 */

trigger TerrUserTrigger on TerrUser__c (before update, before delete, after insert, after update ) {
    if(Trigger.isBefore){
         if (Trigger.isDelete) {
            TerrUserTriggerHandler.deleteOldAccountAndContactShares(Trigger.old);
        }if(Trigger.isUpdate) {
            TerrUserTriggerHandler.deleteOldAccountAndContactShares(Trigger.old);
        }
    }
    if (Trigger.isAfter) {
        if(Trigger.isInsert) {
            TerrUserTriggerHandler.insertNewAccountAndContactShares(Trigger.new);
        }
        if (Trigger.isUpdate) {
            TerrUserTriggerHandler.updateNewAccountAndContactShares(Trigger.new);
        }
    }
}