/*
 * Created by Pepperoner on 02.04.2019.
 */

public with sharing class AccountSharingService {

    public static void createAccountSharingByUserIdAndAccountId(Set<Id> userIds, Set<Id> accountsId){
        List<AccountShare> accountShare = new List<AccountShare>();
        for (Id id : userIds){
            accountShare.addAll(accountShare(id,accountsId));
        }
        insert accountShare;
    }

    public static List<AccountShare> accountShare(Id userId, Set<Id> accountsId) {
        List<AccountShare> shareAccount = new List<AccountShare>();

        for (Id accountId : accountsId) {
            AccountShare accountShare = new AccountShare();
            accountShare.AccountId = accountId;
            accountShare.UserOrGroupId = userId;
            accountShare.AccountAccessLevel = 'Edit';
            accountShare.ContactAccessLevel = 'None';
            accountShare.OpportunityAccessLevel = 'None';
            accountShare.CaseAccessLevel = 'None';
            accountShare.RowCause = 'Manual';
            shareAccount.add(accountShare);
        }
        return shareAccount;
    }

    public static void deleteAccountShareByUserIdAndAccountId(Set<Id> userIds, Set<Id> accountsIds){
        List<AccountShare> accountShares = [
                SELECT Id,
                        UserOrGroupId,
                        AccountId,
                        RowCause
                FROM AccountShare
                WHERE UserOrGroupId IN : userIds
                AND AccountId IN : accountsIds
                AND RowCause = 'Manual'
        ];

        if (!accountShares.isEmpty()) {
            delete accountShares;
        }
    }

    public static List<AccountShare> getAccountSharesByAccountsId(Set<Id> accountIds){
        return [SELECT Id
                        FROM AccountShare
                        WHERE AccountId IN : accountIds
                        AND RowCause = 'Manual'
        ];
    }
}