/**
 * @author eduardo.bisso - dev-builder
 */
public class EventQueue {

    EventQueue__c event;

    EventConfiguration__mdt config;

    public EventQueue() {
        event = new EventQueue__c();
    }

    public EventQueue(EventQueue__c event) {
        this.event = event;
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

    public EventConfiguration__mdt getConfig() {
        return this.config;
    }

    public EventOutboundConfig__mdt getOutboundConfig() {
        return this.config.OutboundConfig__r;
    }

}