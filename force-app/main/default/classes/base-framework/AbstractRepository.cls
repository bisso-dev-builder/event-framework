/**
 * @author eduardo.bisso - dev-builder
 */
public inherited sharing abstract class AbstractRepository {
        
    virtual
    public List<Database.UpsertResult> save (List<SObject> aggregates) {

        if (aggregates == null || aggregates.isEmpty()) return new List<Database.UpsertResult>();

        return Database.upsert (aggregates, false);

    }


    virtual
    public void remove ( SObject record ) {
        
        if (record == null) return;

        remove( new List<SObject> { record } );
    }

    virtual
    public void remove ( List<SObject> records ) {
        if (records == null || records.isEmpty()) return;
        delete records;
    }


}