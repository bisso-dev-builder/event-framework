@isTest
public class CommonsFixtureFactory {

    public static Account newAccountWithFakeId (String name) {

        Account account = newAccount (name);
        IdGenerator.generate(account);
                
        return account;

    }

    public static Account newAccount(String name) {
        return new Account(
                   Name = name
                   , BillingCountry = 'Brazil'
                   , BillingPostalCode = StringGenerator.numeric(8).toString());
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