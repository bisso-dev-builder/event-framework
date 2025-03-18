@isTest
public class OutboundEventConfigTest {

    @isTest
    static void shouldInitializeWithDefaultValues() {
        // Dado (Given)
        OutboundEventConfig config = new OutboundEventConfig();

        // Então (Then)
        System.assertEquals(12000, config.getTimeout(), 'Timeout padrão deve ser 12000');
        System.assertEquals('', config.getEndPointUrl(), 'EndPoint padrão deve ser vazio');
        System.assertEquals(null, config.getNamedCredencial(), 'Named Credential padrão deve ser nulo');
    }

    @isTest
    static void shouldInitializeWithCustomMetadata() {
        // Dado (Given)
        EventOutboundConfig__mdt metadata = OutboundEventConfigFixtureFactory.newEventOutboundConfig('TestResponseClass');

        // Quando (When)
        OutboundEventConfig config = new OutboundEventConfig(metadata);

        // Então (Then)
        System.assertEquals('callout:TestNamedCredential/test/endpoint', config.getEndPointUrl(), 'EndPoint deve ser construído corretamente');
        System.assertEquals(15000, config.getTimeout(), 'Timeout deve ser inicializado corretamente');
        System.assertEquals(null, config.getCertificateName(), 'CertificateName deve ser inicializado corretamente');
        System.assertEquals('POST', config.getHttpMethod(), 'HttpMethod deve ser inicializado corretamente');
        System.assertEquals('{"Content-Type": "application/json"}', config.getHttpHeaders(), 'HttpHeaders deve ser inicializado corretamente');
        System.assertEquals('TestResponseClass', config.getResponseClassName(), 'ResponseClassName deve ser inicializado corretamente');
    }

    @isTest
    static void shouldBuildNamedCredentialWithEnvironment() {
        // Dado (Given)
        EventOutboundConfig__mdt metadata = OutboundEventConfigFixtureFactory.newEventOutboundConfig('TestResponseClass');
        metadata.UseEnvironmentWithCredential__c = true;

        // Quando (When)
        OutboundEventConfig config = new OutboundEventConfig(metadata);
        config.environmentResolver = OutboundEnvironmentResolverTest.newOutboundEnvironmentResolver();

        System.assertEquals('callout:TestNamedCredential_DEV/test/endpoint', config.getEndPointUrl(), 'EndPoint deve ser construído corretamente');

    }

    @isTest
    static void shouldBuildNamedCredentialWithoutEnvironment() {
        // Dado (Given)
        EventOutboundConfig__mdt metadata = OutboundEventConfigFixtureFactory.newEventOutboundConfig('TestResponseClass');
        metadata.UseEnvironmentWithCredential__c = false;

        // Quando (When)
        OutboundEventConfig config = new OutboundEventConfig(metadata);

        // Então (Then)
        System.assert(!config.getEndPointUrl().contains('_test'), 'Named Credential não deve incluir o ambiente quando não configurado');
    }
}