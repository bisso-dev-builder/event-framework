
/**
 * @author eduardo.bisso - dev-builder
 */
public class OAuthOutboundService extends OutboundService {

    public OAuthOutboundService( EventQueue event ) {
        super (event, new CalloutWithOAuthFlow(event) );
    }

    public OAuthOutboundService( EventQueue event, Callout callout) {
        super(event, callout);        
    }

}