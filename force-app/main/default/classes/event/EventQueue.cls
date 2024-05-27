/**
 * @author eduardo.bisso - dev-builder
 */
public class EventQueue {

    EventQueue__c event;

    EventConfiguration config;

    EventQueueRepository repository;
    
    public EventQueue() {
        this.event = new EventQueue__c();
        this.repository = new EventQueueRepository();
    }

    public EventQueue(EventQueue__c event) {
        this();
        this.event = event;
        this.initialize(this.event.EventName__c);
    }

    public EventQueue(String eventName) {
        this( new EventQueue__c (EventName__c = eventName) );
    }

    public void initialize(String eventName) {
        this.config = this.repository.findConfigByName(eventName);       
    }

    public String getObjectId () {
        return this.event.SalesforceObjectId__c;
    }

    public String getStatus () {
        return this.event.Status__c;
    }

    public String getExternalId () {
        return this.event.ExternalId__c;
    }

    public String getId () {
        return this.event.Id;
    }

    public Boolean useCustomOAuthFlow() {
        return String.isNotEmpty( this.config.getOAuthEventName() );
    }

    public Boolean hasError () {
        return getStatus() == EventQueueStatusType.ERROR.name();
    }

    public Boolean isIgnored () {
        return getStatus() == EventQueueStatusType.IGNORED.name();
    }

    public Boolean isUnhandled () {
        return getStatus() == EventQueueStatusType.UNHANDLED.name();
    }

    public EventQueue withConfiguration (EventConfiguration config) {
        this.config = config;
        return this;
    }

    public EventQueue withStatusDetail (String detailedStatus) {
        this.event.DetailedStatus__c = detailedStatus;
        return this;
    }

    public EventQueue withStatus (EventQueueStatusType status) {
        this.event.Status__c =  status.name();
        return this;
    }

    public EventQueue withStackTrace (String stackTrace) {
        this.event.ErrorStackTrace__c =  stackTrace;
        return this;
    }

    public EventQueue withError (Exception e) {
        return withError(e, e.getTypeName() + ' :  { ' +  e.getMessage() + ' }' );
    }
    
    public EventQueue withError (DmlException e) {                
        return withError( e, e.getTypeName() + ' :  { ' +  e.getDmlMessage(0) + ' }' );
    }
    
    public EventQueue withError (Exception e, String errorMessage) {
        
        return withStatus( EventQueueStatusType.ERROR )
            .withStatusDetail(errorMessage)
            .withStackTrace(e.getStackTraceString());

    }

    public EventQueue disableRetry () {
        this.event.RetryCount__c = 0;
        this.event.IsRetryDisabled__c = true;
        return this;        
    }

    public EventQueue decreaseRetry () {
        if (this.event.RetryCount__c == 0) return this;
        this.event.retryCount__c -=  1;
        return this;        
    }

    public EventConfiguration getConfig() {
        return this.config;
    }

    public OutboundEventConfig getOutboundConfig() {
        return this.config.getOutboundConfig();
    }

    public EventQueue getOAuthEvent() {

        if (!useCustomOAuthFlow()) return null;

        return new EventQueue( this.config.getOAuthEventName() );
    }

    public void setRepository (EventQueueRepository repository) {
        this.repository = repository;
    }

    public void log () {
        //
    }
 
    public EventQueue save () {
        
        this.repository.save(this.event);      

        return this;
    }

}