public interface TriggerInterceptor {    

    void setNewRecords (List<SObject> newRecords);

    void setOldRecords (Map<Id,SObject> oldRecords);
    
    void process ();

}