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


    public EventOutboundEnvironment__mdt findEnvironment () {

        String orgName = '%' + env.getOrgName() + '%';

        List<EventOutboundEnvironment__mdt> enviroments = [SELECT OutboundEnvironment__c
                                                                FROM EventOutboundEnvironment__mdt 
                                                                WHERE  OrgEnvironment__c = :env.getType().name()
                                                                AND OrgNames__c LIKE :orgName ];

        return (EventOutboundEnvironment__mdt) Lists.getFirstOrNull (enviroments);                                                                        

    }

}