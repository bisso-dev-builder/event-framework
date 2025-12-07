/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class OutboundEnvironmentResolver {
    
    Environment env;

    public OutboundEnvironmentResolver () {
        this.env = Environment.get();
    }

    public OutboundEnvironmentResolver (Environment env) {        
        this();
        this.env = env;
    }

    public String buidOutboundEnvironment () {

        EventOutboundEnvironment__mdt env = findEnvironment ();

        return env?.OutboundEnvironment__c;
    }

    virtual    
    public EventOutboundEnvironment__mdt findEnvironment () {

        List<EventOutboundEnvironment__mdt> environments = findByOrgNameAndEnvironmentType( '%' + env.getOrgName() + '%' , env.getType().name());

        return (EventOutboundEnvironment__mdt) Lists.getFirstOrNull (environments);                                                                        

    }

    virtual
    protected List<EventOutboundEnvironment__mdt> findByOrgNameAndEnvironmentType (String orgName, String environment ) {
        return [SELECT OutboundEnvironment__c FROM EventOutboundEnvironment__mdt 
                    WHERE  OrgEnvironment__c = : environment
                    AND OrgNames__c LIKE :orgName ]; 
    }

}