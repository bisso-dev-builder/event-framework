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

    public CalloutWithOAuthFlow authenticate (Object oauthRequest) {
        
        return null;

    }

    override
    public Object send ( Object requestContent ) {

        super.send(requestContent);

        HttpResponse response = new Http().send( requestBuilder
                                                    .withPayload(requestContent)
                                                    .build() );

        return responseBuilder.buildReponse(response);

    }

    virtual
    override
    public void requestPrepare (Object requestContent) {
            
        super.requestPrepare(requestContent);
        
    }




}