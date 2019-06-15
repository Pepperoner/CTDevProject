/**
 * Created by Pepperoner on 10.04.2019.
 */

trigger AccountTrigger on Account (before delete, after insert, after update) {

    if (Trigger.isBefore) {
        if (Trigger.isDelete) {
            AccountTriggerHandler.deleteContactSharesByAccounts(Trigger.old);
        }
    }

    if (Trigger.isAfter) {
        if (Trigger.isInsert) {
            AccountTriggerHandler.insertAccountAndContactShares(Trigger.new);
        }
        if (Trigger.isUpdate) {
            AccountTriggerHandler.deleteOldSharesAndInsertNewShares(Trigger.new, Trigger.old);
        }
    }
}