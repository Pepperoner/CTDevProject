/**
 * Created by Pepperoner on 10.04.2019.
 */

public with sharing class ContactSharingService {

    public static void createContactSharingByUserIdAndContactId(Set<Id> userIds, Set<Id> contactsId){
        List<ContactShare> contactShare = new List<ContactShare>();
        for (Id id : userIds){
            contactShare.addAll(contactShare(id,contactsId));
        }
        insert contactShare;
    }

    public static List<ContactShare> contactShare(Id userId, Set<Id> contactIds){
        List<ContactShare> shareContact = new List<ContactShare>();

        for (Id contactId : contactIds){
            ContactShare contactShare = new ContactShare();
            contactShare.ContactId = contactId;
            contactShare.UserOrGroupId = userId;
            contactShare.ContactAccessLevel = 'Edit';
            contactShare.RowCause = 'Manual';
            shareContact.add(contactShare);
        }
        return shareContact;
    }

    public static void deleteContactShareByUserIdAndContactId(Set<Id> userIds, Set<Id> contactsIds){
        List<ContactShare> contactShare = [
                SELECT Id
                FROM ContactShare
                WHERE UserOrGroupId IN : userIds
                AND ContactId IN : contactsIds
                AND RowCause = 'Manual'
        ];

        if (!contactShare.isEmpty()) {
            delete contactShare;
        }
    }

    public static List<ContactShare> getContactSharesByContactsId(Set<Id> contactsId){
        return [SELECT Id
                        FROM ContactShare
                        WHERE ContactId IN : contactsId
                        AND RowCause = 'Manual'];
    }
}