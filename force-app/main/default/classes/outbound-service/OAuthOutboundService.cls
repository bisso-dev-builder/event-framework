
/**
 * @author eduardo.bisso - dev-builder
 */
public class OutboundServiceWithOAuthFlow extends OutboundService {


    public OutboundServiceWithOAuthFlow( EventQueue event ) {
        this (event, new Callout(event) );
    }

    public OutboundServiceWithOAuthFlow( EventQueue event, Callout callout) {
        this(event, callout);        
    }
}