/**
 * @author eduardo.bisso - dev-builder
 */
@isTest
public class SObjectsTest {

    @isTest
    static void shouldGetSObjectFields () {

        SObject account = SObjects.newInstance('Account');
        
        Map<String, Schema.SObjectField> fields = SObjects.getObjectFields('Account');
          
        Assert.isTrue( !fields.isEmpty() );

    }

    @isTest
    public static void shouldGetSObjectValue () {

        String payload = '[ { "Opportunity": { "Account": { "Owner": { "Name": "value 1" } } } }, { "Opportunity": { "Account": { "Owner": { "Name": "value 2" } } } }, { "Opportunity": { "Account": { "Owner": { "Name": "value 3" } } } }, { "Opportunity": { "Account": { "Owner": { "Name": "value 4" } } } } ]';

        List<OpportunityLineItem> opportunityLineItems = (List<OpportunityLineItem>) JSON.deserialize(payload,List<OpportunityLineItem>.class);
        
        Assert.isFalse (opportunityLineItems.isEmpty());
        Assert.areEqual( 4, opportunityLineItems.size());  
        
        Assert.areEqual ('value 1', SObjects.getFieldValue( opportunityLineItems.get(0) , 'Opportunity.Account.Owner.Name') );
        Assert.areEqual ('value 2', SObjects.getFieldValue( opportunityLineItems.get(1) , 'Opportunity.Account.Owner.Name') );
        Assert.areEqual ('value 3', SObjects.getFieldValue( opportunityLineItems.get(2) , 'Opportunity.Account.Owner.Name') );
        Assert.areEqual ('value 4', SObjects.getFieldValue( opportunityLineItems.get(3) , 'Opportunity.Account.Owner.Name') );
        
        
    }

    @isTest
    public static void shouldReturnNewObjectInstance() {
        
        SObject account = SObjects.newInstance('Account');

        Assert.areEqual( 'Account' , account.getSObjectType().getDescribe().getName() );

        Assert.areEqual( 'Account' ,  SObjects.getObjectName(account) );

        Assert.areEqual( 'Account' ,  SObjects.getObjectName( new List<SObject> { account } ) );

        List<Order> orders = new List<Order> { new Order ( PoNumber = '1234') };

        try {

            List<Order> newOrderInstance = (List<Order>) SObjects.newEmptyList(orders);

            Assert.isTrue(newOrderInstance != null);


        } catch (Exception e) {
            Assert.fail();
        }

        try {

            Map<String, Order> emptyOrdersMap = (Map<String, Order>) SObjects.newEmptyMap(orders);
            
            Assert.isTrue(emptyOrdersMap != null);

            Map<String, Order> emptyOrdersMapTwo = (Map<String, Order>) SObjects.newEmptyMap(orders, Order.class); 

            Assert.isTrue(emptyOrdersMapTwo != null);

        } catch (Exception e) {
            Assert.fail();
        }

        try {

            Map<String, List<Order>> emptyOrdersMap = ( Map<String, List<Order>> ) SObjects.newEmptyGroupedMap(orders);

            Assert.isTrue(emptyOrdersMap != null);

        } catch (Exception e) {
            Assert.fail();
        }

    }



}