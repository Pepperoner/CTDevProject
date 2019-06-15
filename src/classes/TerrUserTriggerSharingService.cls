/*
 * Created by Pepperoner on 01.04.2019.
 */

public with sharing class TerrUserTriggerSharingService {

    public static void insertNewAccountAndContactSharing(List<TerrUser__c> terrUsers){
        Set<Id> territoriesId = TerrUserService.getTerritoriesId(terrUsers);
        Set<Id> usersId = TerrUserService.getUsersId(terrUsers);
        Set<Id> accountsIds = ReferenceService.getAccountByTerritoryId(territoriesId);
        Set<Id> contactsIds = ReferenceService.getContactByAccountId(accountsIds);

        AccountSharingService.createAccountSharingByUserIdAndAccountId(usersId,accountsIds);
        ContactSharingService.createContactSharingByUserIdAndContactId(usersId,contactsIds);
    }

    public static void deleteOldAccountAndContactSharing(List<TerrUser__c> terrUsers) {
        Set<Id> territoriesId = TerrUserService.getTerritoriesId(terrUsers);
        Set<Id> usersId = TerrUserService.getUsersId(terrUsers);
        Set<Id> accountsIds = ReferenceService.getAccountByTerritoryId(territoriesId);
        Set<Id> contactsIds = ReferenceService.getContactByAccountId(accountsIds);

        AccountSharingService.deleteAccountShareByUserIdAndAccountId(usersId, accountsIds);
        ContactSharingService.deleteContactShareByUserIdAndContactId(usersId, contactsIds);
    }
}