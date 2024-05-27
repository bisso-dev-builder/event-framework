/**
 * @author eduardo.bisso - dev-builder
 */
@isTest
public class EnvironmentTest {

    @isTest
    public static void shouldBuildDevelopEnviroment () {

        Environment env = newEnvironment('dev-builder-dev-ed.develop.lightning.force.com');
        
        Assert.areEqual( env.host, env.getHost() , 'Expected Host' );
        Assert.areEqual( Environment.EnvironmentType.DEVELOP, env.getType() , 'Expected Develop Environment' );
        Assert.areEqual( 'dev-builder-dev-ed', env.getOrgName() , 'Expected dev-builder-dev-ed' );
        
    }

    @isTest
    public static void shouldBuildScratchEnviroment () {

        Environment env = newEnvironment('dev-builder-dev-ed.scratch.lightning.force.com');

        Assert.areEqual( Environment.EnvironmentType.SCRATCH, env.getType() , 'Expected SCRATCH Environment' );
        Assert.areEqual( 'dev-builder-dev-ed', env.getOrgName() , 'Expected dev-builder-dev-ed' );
        
    }


    @isTest
    public static void shouldBuildSandboxEnviroment () {

        Environment env = newEnvironment('dev-builder--dev-ed.sandbox.lightning.force.com');

        Assert.areEqual( Environment.EnvironmentType.SANDBOX, env.getType() , 'Expected Develop SANDBOX' );
        Assert.areEqual( 'dev-ed', env.getOrgName() , 'Expected dev-ed' );
        
    }


    @isTest
    public static void shouldBuildProductionEnviroment () {

        Environment env = newEnvironment('dev-builder--dev-ed.lightning.force.com');

        Assert.areEqual( Environment.EnvironmentType.PRODUCTION, env.getType() , 'Expected Develop PRODUCTION' );
        Assert.areEqual( 'dev-builder--dev-ed', env.getOrgName() , 'Expected dev-builder-dev-ed' );
        
    }


    @isTest
    public static void shouldBuildCurrentEnviroment () {

        Environment env = Environment.get();
        
        //force s
        env.host = 'dev-builder--dev-ed.lightning.force.com';
        env.parse();

        Assert.areEqual( Environment.EnvironmentType.PRODUCTION, env.getType() , 'Expected Develop PRODUCTION' );
        Assert.areEqual( 'dev-builder--dev-ed', env.getOrgName() , 'Expected dev-builder-dev-ed' );
        
    }


    public static Environment newEnvironment (String host) {
        Environment env = new Environment();
        env.host = host;
        env.parse();

        return env;
    }


}