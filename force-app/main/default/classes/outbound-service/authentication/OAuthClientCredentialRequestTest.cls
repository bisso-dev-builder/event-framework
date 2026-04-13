@isTest
public class OAuthClientCredentialRequestTest {

    @isTest
    static void shouldReturnClientIdAndClientSecret() {
        // Given
        String clientId = 'my-client-id';
        String clientSecret = 'my-client-secret';

        OAuthClientCredentialRequest request = new OAuthClientCredentialRequest()
            .clientId(clientId)
            .clientSecret(clientSecret);

        // When / Then
        Assert.areEqual(clientId, request.getClientId(), 'Should return the configured client id');
        Assert.areEqual(clientSecret, request.getClientSecret(), 'Should return the configured client secret');
    }

}
