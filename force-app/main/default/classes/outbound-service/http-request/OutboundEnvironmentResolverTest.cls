/**
 * @author eduardo.bisso - dev-builder
 */
@isTest
public class OutboundEnvironmentResolverTest {
    
    @isTest
    public static void shouldReturnOutboundEnvironment() {
        
        Assert.areEqual( 'DEVELOPMENT', newOutboundEnvironmentResolver().buidOutboundEnvironment() );

    }

    public static OutboundEnvironmentResolver newOutboundEnvironmentResolver () {

        Environment env = EnvironmentTest.newEnvironment('dev-builder-dev-ed.develop.lightning.force.com');

        return new OutboundEnvironmentResolver(env);
    }

}