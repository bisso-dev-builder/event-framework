@isTest
public class BaseAuthTokenTest {

    @isTest
    static void shouldCreateBaseAuthTokenWithDefaultValues() {
        // Dado (Given)
        BaseAuthToken expectedToken = BaseAuthTokenFixtureFactory.newBaseAuthToken();

        // Quando (When)
        BaseAuthToken actualToken = new BaseAuthToken()
            .tokenType('Bearer')
            .issuedAt('2023-10-01T12:00:00Z')
            .clientId('TestClientId')
            .accessToken('TestAccessToken')
            .scope('read write')
            .expiresIn('3600')
            .refreshCount('1')
            .status('active');

        // Então (Then)
        System.assertEquals(expectedToken.token_type, actualToken.token_type, 'O tipo de token deve ser igual.');
        System.assertEquals(expectedToken.issued_at, actualToken.issued_at, 'A data de emissão deve ser igual.');
        System.assertEquals(expectedToken.client_id, actualToken.client_id, 'O client_id deve ser igual.');
        System.assertEquals(expectedToken.access_token, actualToken.access_token, 'O access_token deve ser igual.');
        System.assertEquals(expectedToken.scope, actualToken.scope, 'O escopo deve ser igual.');
        System.assertEquals(expectedToken.expires_in, actualToken.expires_in, 'O tempo de expiração deve ser igual.');
        System.assertEquals(expectedToken.refresh_count, actualToken.refresh_count, 'O contador de atualização deve ser igual.');
        System.assertEquals(expectedToken.status, actualToken.status, 'O status deve ser igual.');
    }

    // Teste para verificar a criação de um token com um accessToken específico
    @isTest
    static void shouldCreateBaseAuthTokenWithSpecificAccessToken() {
        // Dado (Given)
        String accessToken = 'SpecificAccessToken';
        BaseAuthToken expectedToken = BaseAuthTokenFixtureFactory.createBaseAuthToken(accessToken);

        // Quando (When)
        BaseAuthToken actualToken = new BaseAuthToken(accessToken)
            .tokenType('Bearer')
            .issuedAt('2023-10-01T12:00:00Z')
            .clientId('TestClientId')
            .scope('read write')
            .expiresIn('3600')
            .refreshCount('1')
            .status('active');

        // Então (Then)
        System.assertEquals(expectedToken.access_token, actualToken.access_token, 'O access_token deve ser igual.');
    }

    // Teste para verificar o método toString
    @isTest
    static void shouldSerializeBaseAuthTokenToJson() {
        // Dado (Given)
        BaseAuthToken token = BaseAuthTokenFixtureFactory.newBaseAuthToken();
        String expectedJson = JSON.serialize(token, true);

        // Quando (When)
        String actualJson = token.toString();

        // Então (Then)
        System.assertEquals(expectedJson, actualJson, 'A serialização JSON deve ser igual.');
    }
}