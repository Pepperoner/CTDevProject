/*
 * Created by Pepperoner on 01.04.2019.
 */

public with sharing class TerrUserTriggerHandler {
    public static void insertNewAccountAndContactShares(List<TerrUser__c> terrUsers){
        TerrUserTriggerSharingService.insertNewAccountAndContactSharing(terrUsers);
    }

    public static void deleteOldAccountAndContactShares(List<TerrUser__c> terrUsers){
        TerrUserTriggerSharingService.deleteOldAccountAndContactSharing(terrUsers);
    }

    public static void updateNewAccountAndContactShares(List<TerrUser__c> terrUsers){
        TerrUserTriggerSharingService.insertNewAccountAndContactSharing(terrUsers);
    }
}