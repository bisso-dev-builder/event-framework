public virtual class LeadRepository extends AbstractRepository {
    
    virtual
    public Lead findById(String id) {
             
        if (String.isBlank(id)) {
            return null;
        }

        List<Lead> leads = [ SELECT Id, FirstName, LastName, Company, Email
                                , Street, State, Country,PostalCode 
                            FROM Lead
                            WHERE Id = :id ];

        return leads.isEmpty() ? null : leads[0];
    }

}