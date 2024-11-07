/**
 * @author eduardo.bisso - dev-builder
 */
public class Environment {

    public enum EnvironmentType { DEVELOP, SCRATCH, SANDBOX, PRODUCTION }

    @TestVisible
    String host;
    
    String orgName;
    
    EnvironmentType type;

    public Environment() {
        this.host = URL.getOrgDomainUrl().getHost();
        this.parse();
    }

    public static Environment get() {
        return new Environment();
    }

    @TestVisible
    private void parse () {

        List<String> hostDetails = this.host.split ('\\.');

        if (hostDetails.contains ('develop')) {
            this.orgName = hostDetails.get(0);
            this.type = EnvironmentType.DEVELOP;
            return;
        }

        if (hostDetails.contains ('scratch')) {
            this.orgName = hostDetails.get(0);
            this.type = EnvironmentType.SCRATCH;
            return;
        }

        if (hostDetails.contains ('sandbox')) {

            List<String> orgNameDetails = hostDetails.get(0).split('--');

            this.orgName = orgNameDetails.size() > 1 ? orgNameDetails.get(1) : orgNameDetails.get(0);

            this.type = EnvironmentType.SANDBOX;

            return;
        }

        this.orgName = hostDetails.get(0);
        this.type = EnvironmentType.PRODUCTION;

    }


    public String getHost() {
        return this.host;
    }

    public String getOrgName() {
        return this.orgName;
    }

    public EnvironmentType getType() {
        return this.type;
    }    

}