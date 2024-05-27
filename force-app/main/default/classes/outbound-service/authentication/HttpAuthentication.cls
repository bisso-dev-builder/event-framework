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
    
    virtual
	public String getHttpHeader () {

        return oauthAuthentication();

    }

	private String oauthAuthentication () {

        if (String.isEmpty(getToken ())) return null;

		return  'Bearer ' + getToken ();
        
	}

    public String getToken () {
        
        if ( !getCache().contains('token') ) return '';

        return (String) getCache().get('token');

    }

    private Cache.OrgPartition getCache() {
        
        if ( partition == null ) {
            partition = Cache.Org.getPartition(cacheName);
        }

        return partition;
    }


}