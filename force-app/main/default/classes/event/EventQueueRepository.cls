/**
 * @author eduardo.bisso - dev-builder
 */
public inherited sharing virtual class EventQueueRepository 
                                            extends AbstractRepository {

    public EventQueueRepository() {
    }    

    public EventQueue__c findById (String id) {

        return [SELECT Id FROM EventQueue__c];
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