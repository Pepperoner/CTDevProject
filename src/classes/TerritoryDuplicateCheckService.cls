/*
 * Created by Pepperoner on 05.04.2019.
 */

public with sharing class TerritoryDuplicateCheckService {

    public static void checkTerritoryNameForDuplicate(List<Territory__c> territories){

        Set<String> newTerritoryName = new Set<String>();
        Set<Id> parentIds = new Set<Id>();

        for (Territory__c territory : territories){
            newTerritoryName.add(territory.Name);
            parentIds.add(territory.TerritorySelfLookup__c);
        }

        List<Territory__c> existingTerritories = getExistingTerritoriesByName(parentIds, newTerritoryName);

        if (existingTerritories.size() == 0) {
            return;
        }

        Map<Id, Set<String>> parentNames = getUsedNamesOnTerritories(existingTerritories);

        for (Territory__c territory : territories){
            if (parentNames.containsKey(territory.TerritorySelfLookup__c) &&
                    parentNames.get(territory.TerritorySelfLookup__c).contains(territory.Name)) {
                territory.addError('Territory' + territory.Name + 'already exists' );
            }
        }
    }

    public static Map<Id, Set<String>> getUsedNamesOnTerritories(List<Territory__c> territories){
        Map<Id, Set<String>> nameOnParentTerritories = new Map<Id, Set<String>>();

        for (Territory__c territory : territories){
            Set<String> childNames = new Set<String>{territory.Name};
            for (Territory__c childTerritory : territory.Territories__r){
                childNames.add(childTerritory.Name);
            }
            nameOnParentTerritories.put(territory.Id, childNames);
        }
        return nameOnParentTerritories;
    }

    public static List<Territory__c> getExistingTerritoriesByName(Set<Id> parentsIds, Set<String> newTerritoryNames){
        return [
                SELECT Id,Name,
                (SELECT Id, Name FROM Territories__r WHERE Name IN : newTerritoryNames)
                FROM Territory__c
                WHERE Id IN : parentsIds
        ];
    }
}