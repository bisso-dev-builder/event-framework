@isTest
public class OutboundEventConfigFixtureFactory {

    public static EventOutboundConfig__mdt newEventOutboundConfig( String responseClassName ) {
        return new EventOutboundConfig__mdt(
            UseEnvironmentWithCredential__c = true,
            NamedCredencial__c = 'TestNamedCredential',
            EndPoint__c = 'test/endpoint',
            Timeout__c = 15000,
            HttpMethod__c = 'POST',
            HttpHeaders__c = '{"Content-Type": "application/json"}',
            ResponseClassName__c = responseClassName
        );
    }


    public static OutboundEventConfig newOutboundConfig (String responseClassName) {
        return new OutboundEventConfig ( newEventOutboundConfig(responseClassName)  );
    }

}