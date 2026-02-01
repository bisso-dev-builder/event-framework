public abstract class TriggerFilter extends Filter {

    protected List<SObject> newRecords;
    protected Map<Id, SObject> oldRecords;

    public TriggerFilter (List<SObject> newRecords
                        , Map<Id, SObject> oldRecords ) {
        super();
        this.newRecords = newRecords;
        this.oldRecords = oldRecords;
    }

    public abstract List<SObject> applyFilter ();

}