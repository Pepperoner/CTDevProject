/**
 * Created by Pepperoner on 10.04.2019.
 */

public with sharing class AccountTriggerHandler {

    public static void insertAccountAndContactShares(List<Account> accounts){
        AccountTriggerSharingService.insertAccountAndContactShares(accounts);
    }

    public static void deleteContactSharesByAccounts(List<Account> accounts){
        AccountTriggerSharingService.deleteContactSharesByAccounts(accounts);
    }

    public static void deleteOldSharesAndInsertNewShares(List<Account> newAccounts, List<Account> oldAccounts){

    }
}