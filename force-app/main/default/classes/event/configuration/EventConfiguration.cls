/**
 * @author eduardo.bisso - dev-builder
 */
public class EventConfiguration {
    
    String eventName;
    
    String commandClassName;    
    
    OutboundEventConfig outboundConfig;
    
    String oAuthEventName;

    Boolean disabled;
    Boolean enableTraceLog;
    Integer retry;

    public EventConfiguration() {
        this.retry = 10;
        this.disabled = false;
        this.enableTraceLog = true;
    }

    public EventConfiguration(EventConfiguration__mdt config) {

        this();
        
        if (config == null) return;

        eventName (config.DeveloperName)
            .commandClassName(config.CommandClassName__c)            
            .retryCount( config.Retry__c?.intValue() ?? 10 )
            .enableTraceLog(config.EnableTraceLog__c ?? true )
            .oauthEventName( config.OAuthEventName__c )
            .disabled(config.Disabled__c ?? false);

        if (config.OutboundConfig__r != null) {
            outboundConfig( new OutboundEventConfig(config.OutboundConfig__r));
        }
    }

    public String getEventName () {
        return this.eventName;
    }

    public String getCommandClassName() {
        return this.commandClassName;
    }

    public OutboundEventConfig getOutboundConfig() {
        return this.outboundConfig;
    }

    public Boolean isDisabled() {
        return this.disabled;
    }

    public Boolean isEnableTraceLog() {
        return this.enableTraceLog;
    }

    public Integer getRetry() {
        return this.retry;
    }

    public String getOAuthEventName () {
        return this.oAuthEventName;
    }

    public EventConfiguration eventName (String eventName) {
        this.eventName = eventName;
        return this;
    }    

    public EventConfiguration commandClassName(String commandClassName) {
        this.commandClassName = commandClassName;
        return this;
    }

    public EventConfiguration outboundConfig(OutboundEventConfig outboundConfig) {
        this.outboundConfig = outboundConfig;
        return this;
    }

    public EventConfiguration disabled(Boolean disabled) {
        this.disabled = disabled;
        return this;
    }

    public EventConfiguration enableTraceLog(Boolean enableTraceLog) {
        this.enableTraceLog = enableTraceLog;
        return this;
    }

    public EventConfiguration retryCount(Integer retry) {
        this.retry = retry;
        return this;
    }

    public EventConfiguration oauthEventName (String oauthEventName) {
        this.oAuthEventName = oauthEventName;
        return this;
    }
    
    public Boolean hasCommandHandler () {
        return this.commandClassName != null;
    }

    public Command getCommand () {
        return CommandFactory.newInstance(getCommandClassName());
    }

    public static List<EventConfiguration> buildConfigs (List<EventConfiguration__mdt> configs) {

        List<EventConfiguration> eventConfigs = new  List<EventConfiguration>();

        for (EventConfiguration__mdt config: configs) {

            eventConfigs.add ( new EventConfiguration(config) );
        }

        return eventConfigs;

    }

}