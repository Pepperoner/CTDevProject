/**
 * Created by Pepperoner on 10.04.2019.
 */

public with sharing class AccountTriggerSharingService {

    public static void insertAccountAndContactShares(List<Account> accounts){
        List<AccountShare> accountShares = new List<AccountShare>();
        List<ContactShare> contactShares = new List<ContactShare>();
        List<Reference__c> accountReferences = new List<Reference__c>();
        Set<Id> accountsId = new Set<Id>();
        Set<Id> contactsId = new Set<Id>();

        for (Account account : accounts){
            accountsId.add(account.Id);
        }

        accountShares = AccountSharingService.getAccountSharesByAccountsId(accountsId);
        if (!accountShares.isEmpty()) {
            insert accountShares;
        }

        contactsId = ReferenceService.getContactByAccountId(accountsId);
        contactShares = ContactSharingService.getContactSharesByContactsId(contactsId);
        if (!contactShares.isEmpty()) {
            insert contactShares;
        }
    }

    public static void deleteOldAccountAndContactShares(Set<Id> accountIds){
        List<AccountShare> accountShares = new List<AccountShare>();

        accountShares = AccountSharingService.getAccountSharesByAccountsId(accountIds);

        if (!accountShares.isEmpty()) {
            delete accountShares;
        }
    }

    public static void deleteContactSharesByAccounts(List<Account> accounts){
        List<ContactShare> contactShares = new List<ContactShare>();
        Set<Id> contactsId = ReferenceService.getContactByAccountListId(accounts);

        contactShares = ContactSharingService.getContactSharesByContactsId(contactsId);

        if (!contactShares.isEmpty()) {
            delete contactShares;
        }
    }

}