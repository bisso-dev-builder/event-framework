public class OutboundClientCredentialBuilder {
    
    OutboundEventConfig config;

    public OutboundClientCredentialBuilder(EventQueue event) {
        this.config = event.getOutboundConfig();
    }

    public OAuthClientCredentialRequest build () {
        return new OAuthClientCredentialRequest()
                    .clientId(config.getClientIdCredentialVariable())
                    .clientSecret(config.getClientSecretCredentialVariable());

    }



}