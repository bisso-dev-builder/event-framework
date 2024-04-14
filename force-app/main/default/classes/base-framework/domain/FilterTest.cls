/**
 * @author eduardo.bisso - dev-builder
 */
@isTest
public class FilterTest {


    public static List<Account> setupAccounts() {

        List<Account> accounts = new List<Account> ();
        
        Account accountOne = AccountFixtureFactory.newWithFakeId('One Account');
        accountOne.Type = 'Consulting';
        accountOne.BillingStreet = 'BillingStreet';
        
        Account accountTwo = AccountFixtureFactory.newWithFakeId('Two Account');
        accountTwo.Type = 'Health Care';
        accountTwo.BillingStreet = 'BillingStreet';

        accounts.add(accountOne);
        accounts.add(accountTwo);

        return accounts;
        
    }

    @isTest
    public static void givenRecordsWhenFilterByNotNullThenReturnRecords () {

        Filter filter = new Filter();

        List<Account> newAccounts = setupAccounts();

        Account otherAccount = AccountFixtureFactory.newWithFakeId('Other Account');
        otherAccount.Type = null;
        
        newAccounts.add(otherAccount);

        List<Account> notNullType = filter.byNotNull(newAccounts, 'Type');
       
        System.assertEquals(3, newAccounts.size());
        System.assertEquals(2, notNullType.size());

    }

    @isTest
    public static void givenRecordsWhenFilterByNullThenReturnRecordsWithNullContent () {

        Filter filter = new Filter();

        List<Account> newAccounts = setupAccounts();

        Account otherAccount = AccountFixtureFactory.newWithFakeId('Other Account');
        otherAccount.Type = null;
        
        newAccounts.add(otherAccount);

        List<Account> nullType = filter.byNull(newAccounts, 'Type');
       
        System.assertEquals(3, newAccounts.size());
        System.assertEquals(1, nullType.size());

        System.assertEquals( otherAccount.Name , nullType.get(0).Name);

    }


    @isTest
    public static void shouldFilterEmptyValueForRecords () {

        Filter filter = new Filter();

        List<Account> newAccounts = setupAccounts();

        Account otherAccount = AccountFixtureFactory.newWithFakeId('Other Account');
        otherAccount.Type = null;
        
        newAccounts.add(otherAccount);

        List<Account> emptyType = filter.byEmpty(newAccounts, 'Type');
       
        System.assertEquals(3, newAccounts.size());
        System.assertEquals(1, emptyType.size());

        System.assertEquals( otherAccount.Name , emptyType.get(0).Name);

    }

    @isTest
    public static void shouldFilterNotEmptyValueForRecords () {

        Filter filter = new Filter();

        List<Account> newAccounts = setupAccounts();

        Account otherAccount = AccountFixtureFactory.newWithFakeId('Other Account');
        otherAccount.Type = null;
        
        newAccounts.add(otherAccount);

        List<Account> notEmptyType = filter.byNotEmpty(newAccounts, 'Type');
       
        System.assertEquals(3, newAccounts.size());
        System.assertEquals(2, notEmptyType.size());

        System.assertEquals( newAccounts.get(0).Name , notEmptyType.get(0).Name);

    }    

}