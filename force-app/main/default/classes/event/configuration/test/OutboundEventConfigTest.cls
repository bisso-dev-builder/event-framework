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
        System.assertEquals('callout:TestResponseClass/test/endpoint', config.getEndPointUrl(), 'EndPoint deve ser construído corretamente');
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

        System.assertEquals('callout:TestResponseClass_DEV/test/endpoint', config.getEndPointUrl(), 'EndPoint deve ser construído corretamente');

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

    @isTest
    static void shouldApplyEnvironmentToExternalCredentialVariable() {
        // Covers lines 165, 167: applyEnvironmentInExternalCredetial when externalCredentialName is set
        // Given
        OutboundEventConfig config = new OutboundEventConfig()
            .clientIdCredentialVariable('MyCredential.client_id')
            .clientSecretCredentialVariable('MyCredential.client_secret')
            .externalCredentialName('MyCredential');

        config.environmentResolver = OutboundEnvironmentResolverTest.newOutboundEnvironmentResolver();

        // When
        String clientId = config.getClientIdCredentialVariable();
        String clientSecret = config.getClientSecretCredentialVariable();

        // Then
        Assert.isTrue(clientId.contains('MyCredential_DEV'),
            'Client ID credential variable should have environment suffix applied');
        Assert.isTrue(clientSecret.contains('MyCredential_DEV'),
            'Client secret credential variable should have environment suffix applied');
    }

    @isTest
    static void shouldSkipEnvironmentSetup() {
        OutboundEventConfig config = new OutboundEventConfig()
            .clientIdCredentialVariable('MyCredential.client_id')
            .clientSecretCredentialVariable('MyCredential.client_secret')
            .externalCredentialName('');

        // When
        String clientId = config.getClientIdCredentialVariable();
        String clientSecret = config.getClientSecretCredentialVariable();

        // Then
        Assert.isFalse(clientId.contains('MyCredential_DEV'),
            'Client ID credential variable should have environment suffix applied');
        Assert.isFalse(clientSecret.contains('MyCredential_DEV'),
            'Client secret credential variable should have environment suffix applied');


        Assert.isTrue(clientId.contains('MyCredential'),
            'Client ID credential variable should have environment suffix applied');
        Assert.isTrue(clientSecret.contains('MyCredential'),
            'Client secret credential variable should have environment suffix applied');            

    }

}