public class SapAccountOutboundTransformer {

    public GetSapAccountRequest toGetSapAccountRequest (String document) {

        return new GetSapAccountRequest(document);

    }

}