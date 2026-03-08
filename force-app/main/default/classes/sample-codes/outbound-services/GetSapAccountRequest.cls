public class GetSapAccountRequest {
    
    String q;

    public GetSapAccountRequest() {
        q = 'SELECT AccountNumber, Name, BillingCity, BillingCountry,  BillingPostalCode, BillingState, BillingStreet, Id FROM Account WHERE AccountNumber= '; 
    }

    public GetSapAccountRequest(String accountNumber) {
        this();
        q += '\'' + accountNumber + '\''; 
    }


}