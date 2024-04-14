/**
 * @author eduardo.bisso - dev-builder
 */
public inherited sharing abstract class AbstractRepository {

    virtual
    public SObject save ( SObject aggregate ) {

        if ( aggregate == null ) return aggregate;        

        save( new List<SObject>{aggregate});

        return aggregate;

    }
        
    virtual
    public List<SObject> save (List<SObject> aggregates) {

        if ( Lists.isEmpty( aggregates ) ) return new List<SObject>();

        List<Database.UpsertResult> results = uppsert (aggregates);
        
        return addError(aggregates, results);

    }

    virtual
    public SObject save ( SObject aggregate, Schema.SObjectField field ) {

        if ( aggregate == null ) return aggregate;        

        save( new List<SObject>{aggregate}, field);

        return aggregate;

    }

    virtual 
    public  List<SObject> save ( List<SObject> aggregates, Schema.SObjectField field) {

        if ( Lists.isEmpty( aggregates ) ) return new List<SObject>();

        List<Database.UpsertResult> results = uppsert(aggregates, field);

        return addError(aggregates, results);
    }

    virtual
    public List<SObject> saveRelated ( SObject masterRecord
                                        , String lookupFieldName
                                        , List<SObject> aggregates ) {
        
        SObjectMapper.applyMasterRecord( masterRecord, lookupFieldName , aggregates);

        return save(aggregates);
    } 

    @SuppressWarnings ('PMD.ExcessiveParameterList')
    virtual
    public List<SObject> saveRelated ( SObject masterRecord
                                        , String lookupFieldName
                                        , List<SObject> aggregates 
                                        , Schema.SObjectField field) {
        
        if ( Lists.isEmpty( aggregates ) ) return new List<SObject>();

        SObjectMapper.applyMasterRecord( masterRecord, lookupFieldName, aggregates);

        return save (aggregates, field);
    }  

    //used for mock tests
    virtual
    protected List<Database.UpsertResult> uppsert ( List<SObject> aggregates
                                                , Schema.SObjectField field ) {

        List<Database.UpsertResult> results = Database.upsert(aggregates, field, false);
        System.debug(JSON.serialize(results));
        return results;

    }

    virtual
    protected List<Database.UpsertResult> uppsert ( List<SObject> aggregates ) {

        List<Database.UpsertResult> results = Database.upsert(aggregates, false);

        System.debug(JSON.serialize(results));

        return results;

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

    private List<SObject> addError (List<SObject> storedResults
                                    , List<Database.UpsertResult> results) {

        Integer i = 0;
        
        System.debug(JSON.serialize(results));

        for ( Database.UpsertResult result : results ) {

            if (!result.isSuccess()) {

                storedResults[i].addError( getErrorMessage(result.getErrors()));                

            }

            i++;
        }

        return storedResults;

    }

    private String getErrorMessage (List<Database.Error> errors ) {

        List<String> error = new List<String>();

        for (Database.Error err : errors) {
            error.add (err.getMessage());
        }

        return String.join( error, ', ');
    }

}