/**
 * @author eduardo.bisso - dev-builder
 */
public class EventConfiguration {
    
    String commandClassName;    
    
    OutboundEventConfig outboundConfig;
    
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

        commandClassName(config.CommandClassName__c)
            .outboundConfig( new OutboundEventConfig(config.OutboundConfig__r))
            .retryCount( config.Retry__c?.intValue())
            .enableTraceLog(config.EnableTraceLog__c)
            .disabled(config.Disabled__c);
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

}