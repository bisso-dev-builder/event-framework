/**
 * @author eduardo.bisso - dev-builder
 */
@isTest
public class AbstractRepositoryTest {

    @isTest
    public static void givenValidAccountWhenSaveThenCreateRecordId () {

        Account account = AccountFixtureFactory.newAccount ('One');

        AccountRepository repository = new AccountRepository();

        repository.save (account);

        System.assert ( account.Id != null);

        account.Name = 'One Plus';
        repository.save (account);

        System.assert ( account.Id != null);
        System.assert ( account.Name == 'One Plus');

    }

    @isTest
    public static void givenValidAccountWhenSaveAllThenAllCreateRecordId () {

        Account account = AccountFixtureFactory.newAccount ('One');

        AccountRepository repository = new AccountRepository();

        repository.save (new List<SObject> {account});

        System.assert ( account.Id != null);

        account.Name = 'One Plus';
        repository.save (account);

        System.assert ( account.Id != null);
        System.assert ( account.Name == 'One Plus');



    }

    @isTest
    public static void givenStoredAccountWhenRemoveThenNoMoreAccounts () {

        Account account = AccountFixtureFactory.save('One');

        AccountRepository repository = new AccountRepository();

        System.assert ( account.Id != null);
        
        repository.remove(account);

        List<Account> accounts = [SELECT Id FROM Account];

        System.assert ( accounts.isEmpty()  );       

    }    

    @isTest
    public static void givenAccountAndContactWhenSaveThenAccountsAndContactsWithAccounts () {

        Account account = AccountFixtureFactory.newAccount('One');

        List<Contact> contacts = new List<Contact> { new Contact (LastName = 'One', Email ='one@mail.com') };
        
        AccountRepository repository = new AccountRepository();

        repository.save (account);

        repository.saveRelated(account, 'AccountId', contacts );

        System.assert ( account.Id != null);

        System.assert ( contact.Id != null);
        System.assert ( contact.AccountId != null);

    }    


    @isTest
    public static void givenAccountAndContactWhenSaveRelatedWithExternalIdThenReturnContactsWithAccounts () {

        Account account = AccountFixtureFactory.newWithFakeId('One');

        List<Contact> contacts = new List<Contact> { new Contact (LastName = 'One', Email ='one@mail.com') };
        
        AbstractRepository repository = new AbstractRepositoryMock();

        Schema.SObjectField EXTERNAL_ID = Contact.Email.getDescribe().getSObjectField();

        List<Contact> storedContacts = (List<Contact>) repository.saveRelated(account
                                                                         , 'AccountId'
                                                                         , contacts
                                                                         , EXTERNAL_ID );

        System.assert ( storedContacts.get(0).Id != null);
        System.assert ( storedContacts.get(0).AccountId != null);

    }

    @isTest
    public static void givenRecordsWithExternalIdWhenSaveThenReturnSuccessCreatedRecord() {

        AbstractRepository repository = new AbstractRepositoryMock ();

        Account newAccount = AccountFixtureFactory.newAccount('One');
        
        Schema.SObjectField EXTERNAL_ID = Account.NaicsCode.getDescribe().getSObjectField();

        Account stored = (Account) repository.save (newAccount, EXTERNAL_ID);

        Assert.isNotNull(stored.Id);
        
        List<Account> otherAccounts = new List<Account> { AccountFixtureFactory.newAccount('Other') };
        
        List<Account> otherStoredAccounts = (List<Account>) repository.save ( otherAccounts , EXTERNAL_ID);
        
        Assert.isNotNull(otherStoredAccounts.get(0).Id);

    }

    @isTest
    public static void sholdReturnErrors () {

        Account account = AccountFixtureFactory.newAccount( StringGenerator.text(1000) );

        new AccountRepository().save (account);

        Assert.isTrue( account.hasErrors() );
        
    }

    @isTest
    public static void sholdReturnErrorsOnRelated () {

        Account account = AccountFixtureFactory.save('One');

        List<Contact> contacts = new List<Contact> { new Contact (LastName = StringGenerator.text(260)
                                                    , Email ='one@mail.com') };
        
        AccountRepository repository = new AccountRepository();

        repository.saveRelated(account, 'AccountId', contacts );

        Assert.isTrue( new Filter().hasError(contacts) );
        
    }
   
    public virtual class AccountRepository extends AbstractRepository {

    }

    public virtual class AbstractRepositoryMock extends AbstractRepository {
        
        virtual
        override
        public List<Database.UpsertResult> uppsert ( List<SObject> aggregates ) {
            
            IdGenerator.generate(aggregates);     

            return generateUpsertResult(aggregates);
           
        }
        
        virtual
        override
        public List<Database.UpsertResult> uppsert ( List<SObject> aggregates
                                                        , Schema.SObjectField field ) {
            
            IdGenerator.generate(aggregates);     
                 
            return generateUpsertResult(aggregates);
           
        }

        virtual    
        protected List<Database.UpsertResult> generateUpsertResult (List<SObject> aggregates) {
            
            List<Map<String,Object>> results = new List<Map<String,Object>>(); 

            for ( SObject aggregate : aggregates ) {

                results.add ( new Map<String,Object> { 
                    'id' => aggregate.Id,
                    'success' => true,
                    'created' => true,
                    'errors' => new List<Database.Error>()
                 });
            }

            return ( List<Database.UpsertResult> ) JSON.deserialize ( JSON.serialize(results) , List<Database.UpsertResult>.class )  ;

        }

    }

    public class AbstractRepositoryErrorMock extends AbstractRepositoryMock {

        override
        public List<Database.UpsertResult> generateUpsertResult (List<SObject> aggregates) {    

            List<Map<String,Object>> results = new List<Map<String,Object>>();

            for ( SObject aggregate : aggregates ) {
                results.add ( new Map<String,Object> { 
                    'id' => null,
                    'success' => false,
                    'created' => false,
                    'errors' => builErrors ()
                 });
            }
            return ( List<Database.UpsertResult> ) JSON.deserialize ( JSON.serialize(results) , List<Database.UpsertResult>.class );
        }
        
        private List<Database.Error> builErrors () {

            List<Map<String,Object>> results = new List<Map<String,Object>>();
            
            results.add(  new Map<String,Object> { 
                'statusCode' => 'STRING_TOO_LONG',
                'message' => 'Invalid data',
                'fields' => new List<String> {'Name'}
             });
            
            return ( List<Database.Error> ) JSON.deserialize ( JSON.serialize(results) , List<Database.Error>.class );

        }
    }

}