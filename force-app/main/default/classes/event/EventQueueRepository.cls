/**
 * @author eduardo.bisso - dev-builder
 */
public inherited sharing virtual class EventQueueRepository 
                                            extends AbstractRepository {

    virtual
    public EventQueue__c findById (String id) {

        List<EventQueue__c> events = findByIds( new List<String>{id} );     

        return (EventQueue__c) Lists.getFirstOrNull(events);
    }

    public List<EventQueue__c> findByIds (List<String> ids) {

        return [SELECT Id, EventName__c, ExternalId__c
                    , DocumentNumber__c, CorrelatedNumber__c, SalesforceObjectId__c
                    , RetryCount__c , IsRetryDisabled__c , Status__c , DetailedStatus__c        
                FROM EventQueue__c
                WHERE Id IN :ids];
    }

    public EventConfiguration__mdt findConfigByName (String name) {

        return [ SELECT Id 
                , DeveloperName
                , CommandClassName__c
                , EnableTraceLog__c
                , Retry__c
                , OutboundConfig__r.CertificateName__c
                , OutboundConfig__r.EndPoint__c
                , OutboundConfig__r.Environment__c
                , OutboundConfig__r.HttpHeaders__c
                , OutboundConfig__r.HttpMethod__c
                , OutboundConfig__r.NamedCredencial__c
                , OutboundConfig__r.ResponseClassName__c
                , OutboundConfig__r.Timeout__c                
                FROM EventConfiguration__mdt WHERE DeveloperName =: name];

    }




}