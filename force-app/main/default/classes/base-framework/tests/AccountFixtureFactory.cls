/**
 * @author eduardo.bisso - dev-builder
 */
@isTest
public class AccountFixtureFactory {

    public static Account newWithFakeId (String name) {

        Account account = newAccount (name);
        IdGenerator.generate(account);
                
        return account;

    }

    public static Account newAccount(String name) {
        return new Account(
                   Name = name
                   , BillingCountry = 'Brazil'
                   , BillingState = 'São Paulo');
    }

    public static Account save(String name) {
        return save ( newAccount (name));
    }

    public static Account save (Account account) {

        upsert account;
        return account;

    }

    public static Account fromJson (String payload) {
        return (Account) JSON.deserialize(payload, Account.class);
    }

    public static List<Account> fromJsonArray (String payload) {
        return (List<Account>) JSON.deserialize(payload, List<Account>.class);
    }

}