@isTest
public class TriggerFilterTest {
    
    @isTest
    public static void shouldFiltering () {

        List<Account> newAccounts = FilterTest.setupAccounts();
        newAccounts.get(0).Type = null;
        newAccounts.get(1).Type = 'Value';

        Map<Id, Account> oldAccounts = new Map<Id, Account> ( newAccounts.deepClone(true, true, true));
        oldAccounts.get( newAccounts.get(1).Id ).Type = 'Value1'; 
    
        Test.startTest();
        
        TriggerFilter filter = new AccountSimpleTriggerFilterMock( newAccounts, oldAccounts );

        List<Account> filteredAccounts = filter.applyFilter();
        
        Test.stopTest();

        Assert.areEqual(1, filteredAccounts.size());

        Assert.areEqual( filteredAccounts.get(0).Id, newAccounts.get(1).Id);

        Assert.areEqual( 'Value' , filteredAccounts.get(0).Type);

    }


    public class AccountSimpleTriggerFilterMock extends TriggerFilter {

        public AccountSimpleTriggerFilterMock (List<SObject> newRecords
                            , Map<Id, SObject> oldRecords ) {
            super(newRecords, oldRecords);
        }

        override
        public List<SObject> applyFilter() {            
            return byChangedFields( byNotNull(newRecords, 'Type')
                            , oldRecords, new List<String>{'Type'});                    
        }

    }
 

}