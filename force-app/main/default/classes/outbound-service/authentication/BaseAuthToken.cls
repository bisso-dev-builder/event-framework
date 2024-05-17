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

    override
    public String toString () {
        return JSON.serialize (this, true);
    }

}