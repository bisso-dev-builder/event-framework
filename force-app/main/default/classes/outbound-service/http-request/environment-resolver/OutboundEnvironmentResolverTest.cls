/**
 * @author eduardo.bisso - dev-builder
 */
@isTest
public class OutboundEnvironmentResolverTest {
    
    @isTest
    public static void shouldReturnOutboundEnvironment() {
        
        Assert.areEqual( 'DEV', newOutboundEnvironmentResolver().buidOutboundEnvironment() );

    }

    @isTest
    public static void shouldNullOutboundEnvironment() {
        
        Assert.areEqual( null, newNullOutboundEnvironmentResolver().buidOutboundEnvironment() );

    }


    public static OutboundEnvironmentResolver newOutboundEnvironmentResolver () {

        String payload = '[{"OutboundEnvironment__c":"DEV"}]';

        Environment env = EnvironmentTest.newEnvironment('dev-builder-dev-ed.develop.lightning.force.com');

        return new OutboundEnvironmentResolverMock(payload, env);
    }


    public static OutboundEnvironmentResolver newNullOutboundEnvironmentResolver () {

        Environment env = EnvironmentTest.newEnvironment('xpto.develop.lightning.force.com');

        return new OutboundEnvironmentResolver(env);
    }


    public class OutboundEnvironmentResolverMock extends OutboundEnvironmentResolver {
        String payload;

        public OutboundEnvironmentResolverMock(String payload, Environment env) {
            super(env);
            this.payload = payload;
        }

        override
        protected List<EventOutboundEnvironment__mdt> findByOrgNameAndEnvironmentType (String orgName, String environment ) {

            return (List<EventOutboundEnvironment__mdt>) JSON.deserialize(payload, List<EventOutboundEnvironment__mdt>.class);

        }

    }

}