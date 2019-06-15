/**
 * Created by Pepperoner on 10.04.2019.
 */

public with sharing class TerritoryService {

    public static Map<Id, Set<Territory__c>> getTerritoriesWithParentsByAccount(List<Account> accounts){
        Map<Id, Set<Territory__c>> accountsIdWithUpperHierarchyOfTerritories = new Map<Id, Set<Territory__c>>();
        Map<Id, Id> accountsIdWithTerritoryId = new Map<Id, Id>();

        for (Account account : accounts){
            if(account.AccountToTerritoryLookup__c != null){
                accountsIdWithTerritoryId.put(account.Id, account.AccountToTerritoryLookup__c);
            }
        }

        accountsIdWithUpperHierarchyOfTerritories = getTerritoriesWithParentsByChild(accountsIdWithTerritoryId);

        return accountsIdWithUpperHierarchyOfTerritories;
    }

    private static Map<Id, Set<Territory__c>> getTerritoriesWithParentsByChild(Map<Id,Id> territories){
        Map<Id, Set<Territory__c>> result = new Map<Id, Set<Territory__c>>();
        Set<Territory__c> territoriesWithParent = new Set<Territory__c>();

        for (Id accountId : territories.keySet()){
            //territoriesWithParent = getUpperTerritoriesHierarchy(territories.get(accountId));
            result.put(accountId, territoriesWithParent);
        }
        return result;
    }

    public static List<Territory__c> getChildren(Set<Id> parentIds){
        return [SELECT Id,
                        Name,
                        TerritorySelfLookup__c,
                        (SELECT Id FROM Territories__r)
                        FROM Territory__c];
    }

    //public static Set<Territory__c> getUpperTerritoriesHierarchy(Id territory){
    //    Set<Territory__c> result = new Set<Territory__c>();
    //    Id parent = territory;
//
    //    List<Territory__c> territories = [
    //            SELECT Id,
    //                    TerritorySelfLookup__c
    //            FROM Territory__c
    //            WHERE Id IN :parent
    //            OR TerritorySelfLookup__c IN :parent
    //            OR TerritorySelfLookup__r.TerritorySelfLookup__c IN :parent
    //    ];
    //    if (!territories.isEmpty()) {
    //        result.add(territories);
    //    }
    //    return result;
    //}

    public static void getTerritoriesIdByAccount(){

    }
}