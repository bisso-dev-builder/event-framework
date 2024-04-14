/**
 * @author eduardo.bisso - dev-builder
 */
@isTest
public class SObjectMapperTest {

    @isTest
    public static void shouldApplyMasterRecordId() {

        Account account = AccountFixtureFactory.newWithFakeId('One');

        List<Contact> contacts = new List<Contact> { new Contact (LastName = 'One', Email ='one@mail.com')
                                            , new Contact ( LastName = 'Other', Email = 'other@emai.com' ) };

        Test.startTest();

        SObjectMapper.applyMasterRecord(account, 'AccountId', contacts);

        Test.stopTest();

        for (Contact contact : contacts) {
            Assert.areEqual ( account.Id, contact.AccountId );
        }

    }

    @isTest
    public static void givenSavedContactWithAccountWhenMapThenOlySetAccountIdForNotSavedItems () {

        Account otherAccount = AccountFixtureFactory.newWithFakeId('Other');

        Account account = AccountFixtureFactory.newWithFakeId('One');

        List<Contact> contacts = new List<Contact> { new Contact (LastName = 'One', Email ='one@mail.com', AccountId = otherAccount.Id )
                                            , new Contact ( LastName = 'Other', Email = 'other@emai.com' )
                                            , new Contact ( LastName = 'Other2', Email = 'other2@emai.com' ) };                                           

        Test.startTest();

        SObjectMapper.applyMasterRecord(account, 'AccountId', contacts);

        Assert.areEqual ( otherAccount.Id, contacts.get(0).AccountId );

        Assert.areEqual ( account.Id, contacts.get(1).AccountId );

        Assert.areEqual ( account.Id, contacts.get(2).AccountId );

    }


}