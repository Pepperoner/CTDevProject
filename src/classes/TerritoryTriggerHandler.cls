/*
 * Created by Pepperoner on 05.04.2019.
 */

public with sharing class TerritoryTriggerHandler {

    public static void beforeInsert(List<Territory__c> territories){

        TerritoryDuplicateCheckService.checkTerritoryNameForDuplicate(territories);
    }
    public static void beforeUpdate(List<Territory__c> territories){

        TerritoryDuplicateCheckService.checkTerritoryNameForDuplicate(territories);
    }
}