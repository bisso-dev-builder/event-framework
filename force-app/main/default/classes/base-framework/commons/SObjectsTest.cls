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