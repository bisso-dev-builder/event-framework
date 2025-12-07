public class GetLeadAddressOutboundCommand extends AbstractOutboundCommand {

    LeadRepository repository;

    Lead lead;

    ViaCepResponse addressResponse;
    
    public GetLeadAddressOutboundCommand() {
        this.repository = new LeadRepository();
    }

    override
    public Object transform() {

        lead = repository.findById( getEvent().getObjectId() );      

        return new Map<String, String> {
            'zipcode' => lead.PostalCode
        };
    }
    
    override
    public void executeUpdate() {
               
        repository.save( toLead (lead
                            , (ViaCepResponse) getResponse() )
                        );

    }


    private Lead toLead ( Lead lead, ViaCepResponse response ) {

        lead.Street = response.logradouro;

        return lead;
    }


}