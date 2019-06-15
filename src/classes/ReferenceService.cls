/*
 * Created by Pepperoner on 04.04.2019.
 */

public with sharing class ReferenceService {

    public static Set<Id> getAccountByTerritoryId(Set<Id> territoryIds){
        Set<Id> accountsIds = new Set<Id>();
        List<Account> accounts = [
                SELECT Id
                FROM Account
                WHERE AccountToTerritoryLookup__c IN : territoryIds
        ];
        for (Account account :accounts) {
            accountsIds.add(account.Id);
        }
        return accountsIds;
    }

    public static Set<Id> getContactByAccountId(Set<Id> accountsIds){
        Set<Id> contactsIds = new Set<Id>();
        List<Reference__c> references = [
                SELECT ContactToAccountJunction__c
                FROM Reference__c
                WHERE AccountToContactJunction__c IN :accountsIds
        ];
        for (Reference__c reference : references){
            contactsIds.add(reference.ContactToAccountJunction__c);
        }
        return contactsIds;
    }

    public static List<Account> getAccountListByTerritoryId(Set<Id> territoriesId){
        return [SELECT Id
                        FROM Account
                        WHERE AccountToTerritoryLookup__c IN : territoriesId];
    }

    public static Set<Id> getContactByAccountListId(List<Account> accounts){
        Set<Id> contactsIds = new Set<Id>();
        Set<Id> accountIds = new Set<Id>();

        for (Account account : accounts){
            accountIds.add(account.Id);
        }
        List<Reference__c> references = [
                SELECT ContactToAccountJunction__c
                FROM Reference__c
                WHERE AccountToContactJunction__c IN :accountIds
        ];
        for (Reference__c reference : references){
            contactsIds.add(reference.ContactToAccountJunction__c);
        }
        return contactsIds;
    }

    //public static List<Reference__c> getReferencesByAccountId(Set<Id> accountsId){
    //    return [SELECT ContactToAccountJunction__c,
    //                    AccountToContactJunction__c
    //                    FROM Reference__c
    //                    WHERE AccountToContactJunction__c IN : accountsId
    //    ];
    //}
}