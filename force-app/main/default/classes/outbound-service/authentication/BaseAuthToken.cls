/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class BaseAuthToken {

    public String token_type;
    public String issued_at;
    public String client_id;
    public String access_token;
    public String scope;
    public String expires_in;
    public String refresh_count;
    public String status;

    public BaseAuthToken() {
    }

    public BaseAuthToken(String accessToken) {
        this();
        this.access_token = accessToken;
    }

    public BaseAuthToken tokenType(String tokenType) {
        this.token_type = tokenType;
        return this;
    }

    public BaseAuthToken issuedAt(String issuedAt) {
        this.issued_at = issuedAt;
        return this;
    }

    public BaseAuthToken clientId(String clientId) {
        this.client_id = clientId;
        return this;
    }

    public BaseAuthToken accessToken(String accessToken) {
        this.access_token = accessToken;
        return this;
    }

    public BaseAuthToken scope(String scope) {
        this.scope = scope;
        return this;
    }

    public BaseAuthToken expiresIn(String expiresIn) {
        this.expires_in = expiresIn;
        return this;
    }

    public BaseAuthToken refreshCount(String refreshCount) {
        this.refresh_count = refreshCount;
        return this;
    }

    public BaseAuthToken status(String status) {
        this.status = status;
        return this;
    }
    
    override
    public String toString () {
        return JSON.serialize (this, true);
    }

}