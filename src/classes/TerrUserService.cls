/*
 * Created by Pepperoner on 04.04.2019.
 */

public with sharing class TerrUserService {

    public static Set<Id> getTerritoriesId(List<TerrUser__c> terrUsers) {
        Set<Id> currentTerritoryIds = new Set<Id>();
        Set<Id> childTerritoryIds = new Set<Id>();

        for (TerrUser__c terrUser : terrUsers){
            currentTerritoryIds.add(terrUser.TerritoryToUserJunction__c);
        }

        List<Territory__c> firsTerritories = [
                SELECT Id,
                        TerritorySelfLookup__c
                FROM Territory__c
                WHERE Id IN :currentTerritoryIds
                OR TerritorySelfLookup__c IN :currentTerritoryIds
                OR TerritorySelfLookup__r.TerritorySelfLookup__c IN :currentTerritoryIds
        ];
        for (Territory__c territory : firsTerritories){
            if (territory.Id!=null) {
                childTerritoryIds.add(territory.Id);
            } else {
                return currentTerritoryIds;
            }
        }
        return childTerritoryIds;
    }

    public static Set<Id> getUsersId(List<TerrUser__c> terrUsers){
        Set<Id> userIds = new Set<Id>();
        for (TerrUser__c terrUser : terrUsers){
            userIds.add(terrUser.UserToTerritoryLookup__c);
        }
        return userIds;
    }
}