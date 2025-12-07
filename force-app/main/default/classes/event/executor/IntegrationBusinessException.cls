public virtual class IntegrationBusinessException extends Exception {

	public String code;
	public String message;
	public String detailedMessage;	

	public IntegrationBusinessException (String code, String message, String detailedMessage) {
		this ( code , message + '\n Details : ' + detailedMessage ); 
	}

	public IntegrationBusinessException (String code, String message) {
		this (code + ' : ' + message ); 
	}

}