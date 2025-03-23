/**
 * @author eduardo.bisso - dev-builder
 */
public class CalloutWithOAuthFlow extends Callout {

    EventQueue oauthEvent;

    Callout oauthCallout;

    HttpAuthentication authentication;

    public CalloutWithOAuthFlow(EventQueue event) {

        super(event);

        this.oauthEvent = event.getOAuthEvent();

        this.oauthCallout = new Callout(oauthEvent);

    }

    override
    public Object send ( Object requestContent ) {

        authenticate ();

        return super.send(requestContent);

    }

    virtual
    public void authenticate () {
            
        OAuthClientCredentialRequest request = new OutboundClientCredentialBuilder(this.oauthEvent).build();
        
        BaseAuthToken oauthToken = (BaseAuthToken) oauthCallout.send( request );

        this.authentication = new HttpAuthentication (oauthToken.access_token);

        this.requestBuilder.withAuthentication(authentication);

    }

    virtual
    override
    public void requestPrepare (Object requestContent) {
            
        super.requestPrepare(requestContent);
        
    }

}