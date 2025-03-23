
public class OAuthClientCredentialRequest {

    String client_id;
    String client_secret;
    String grant_type;

    public OAuthClientCredentialRequest() {        
        grantType('client_credentials');
    }

    public String getClientId() {
        return this.client_id;
    }

    public String getClientSecret() {
        return this.client_secret;
    }

    public OAuthClientCredentialRequest clientId(String client_id) {
        this.client_id = client_id;
        return this;
    }

    public OAuthClientCredentialRequest clientSecret(String client_secret) {
        this.client_secret = client_secret;
        return this;
    }

    public OAuthClientCredentialRequest grantType(String grant_type) {
        this.grant_type = grant_type;
        return this;
    }
    

}