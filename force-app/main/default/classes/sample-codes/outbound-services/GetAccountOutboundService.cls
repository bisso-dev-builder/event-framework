public class GetAccountOutboundService {

	OutboundService service;

	SapAccountOutboundTransformer transfomer;

    public GetAccountOutboundService() {
        service = new OutboundService('GET_SAP_CUSTOMER_OUTBOUND');
        transfomer = new SapAccountOutboundTransformer();
    }

    public SapAccountResponse findAccountByDocument (String document) {

        GetSapAccountRequest request = transfomer.toGetSapAccountRequest (document);

        SapAccountResponse response = (SapAccountResponse) service.send(request);

        service.getEvent().save();

        return response;

    }

}