/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class HttpAuthentication {

    private static Cache.OrgPartition partition;

    public String cacheName;    

    public String type;

	public String user;

	public String password;

	public String token;

	public HttpAuthentication() {        
	}

    public HttpAuthentication(String token) {
        this();
        this.token = token;
        System.debug(token);
	}
    
    virtual
	public String getHttpHeader () {

        return oauthAuthentication();

    }

	private String oauthAuthentication () {

        if (String.isEmpty(getToken ())) return null;

		return  'Bearer ' + getToken ();
        
	}

    public String getToken () {        

        if ( getCache() == null || !getCache().contains('token') ) return token;

        return (String) getCache().get('token');

    }

    private Cache.OrgPartition getCache() {
        
        if ( partition == null & !String.isEmpty(cacheName)) {
            partition = Cache.Org.getPartition(cacheName);
        }

        return partition;
    }


}