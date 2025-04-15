@isTest
public class BaseAuthTokenFixtureFactory {

    public static BaseAuthToken newBaseAuthToken() {
        return new BaseAuthToken()
            .tokenType('Bearer')
            .issuedAt('2023-10-01T12:00:00Z')
            .clientId('TestClientId')
            .accessToken('TestAccessToken')
            .scope('read write')
            .expiresIn('3600')
            .refreshCount('1')
            .status('active');
    }

    public static BaseAuthToken createBaseAuthToken(String accessToken) {
        return new BaseAuthToken(accessToken)
            .tokenType('Bearer')
            .issuedAt('2023-10-01T12:00:00Z')
            .clientId('TestClientId')
            .scope('read write')
            .expiresIn('3600')
            .refreshCount('1')
            .status('active');
    }
}