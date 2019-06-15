/*
 * Created by Pepperoner on 05.04.2019.
 */

trigger TerritoryTrigger on Territory__c (before insert, before update) {

    if(Trigger.isBefore){
        if(Trigger.isInsert) {
            TerritoryTriggerHandler.beforeInsert(Trigger.new);
        } else if (Trigger.isUpdate) {
            TerritoryTriggerHandler.beforeUpdate(Trigger.new);
        }
    }
}