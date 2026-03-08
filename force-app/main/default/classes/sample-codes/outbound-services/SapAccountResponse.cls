public class SapAccountResponse {


    public Integer totalSize;
    public Boolean done;
    public List<AccountRecord> records;


    public SapAccountResponse() {

    }

    public class AccountRecord {

	    public String AccountNumber;
        public String Name;
        public String BillingAddress;
        public String BillingCity;
        public String BillingCountry;
        public String BillingPostalCode;
        public String BillingState;
        public String BillingStreet;
        public String DunsNumber;
        public String Id;

    }


}