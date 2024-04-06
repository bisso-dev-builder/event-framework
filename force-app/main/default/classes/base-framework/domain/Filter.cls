/**
 * @author eduardo.bisso - dev-builder
 */
public virtual class Filter {

    @SuppressWarnings ('PMD.ExcessiveParameterList')
    public List<SObject> byChangedValue ( List<SObject> newRecords
                                        , Map<Id, SObject> oldRecords
                                        , String changedField
                                        , Object value ) {

        List<SObject> changedRecords = byChangedFields (newRecords, oldRecords, new String[] {changedField} );
                                            
        return byValue(changedRecords, changedField, value);

    }

    public List<SObject> byChangedFields ( List<SObject> newRecords
                                        , Map<Id, SObject> oldRecords
                                        , List<String> changedFields ) {

        List<SObject> changedRecords = new List<SObject>();

        if ( newRecords == null || newRecords.isEmpty() ) return changedRecords;

        if ( oldRecords == null || oldRecords.isEmpty() ) return newRecords;

        for ( SObject record : newRecords  ) {

            SObject oldRecord = oldRecords.get( (Id) record.get('Id') ) ;

            if ( isChanged( record, oldRecord, changedFields) ) {
                changedRecords.add (record);
            }

        }

        return changedRecords;                                            

    }

    public Boolean isChanged (SObject changed , SObject old , List<String> changedFields ) {

        if (old == null) return true;

        for (String field : changedFields) {

            if ( changed.get(field)  !=  old.get(field) ) return true;

        }

        return false;

    }

    public List<SObject> byValue (List<SObject> records, String fieldName, Object value) { 

        List<SObject> changedRecordsWithValue = new List<SObject>();

        for (SObject record : records ) {

            Object recordValue = SObjects.getFieldValue(record, fieldName);

            if (recordValue == null) continue;
            
            if ( recordValue == value ) {
                changedRecordsWithValue.add(record);
            }

        }

        return changedRecordsWithValue;

    }

    public List<SObject> byNotNull (List<SObject> records, String fieldName) { 

        List<SObject> filtered = new List<SObject>();

        for (SObject record : records ) {

            if (SObjects.getFieldValue(record, fieldName) == null) continue;

            filtered.add(record);

        }

        return filtered;

    }

    public List<SObject> byNull (List<SObject> records, String fieldName) { 

        List<SObject> filtered = new List<SObject>();

        for (SObject record : records ) {

            if (SObjects.getFieldValue(record, fieldName) != null) continue;

            filtered.add(record);

        }

        return filtered;

    }

    public List<SObject> byNotEmpty (List<SObject> records, String fieldName) { 

        List<SObject> filtered = new List<SObject>();

        for (SObject record : records ) {

            String value = (String) SObjects.getFieldValue(record, fieldName);

            if ( String.isEmpty(value) ) continue;

            filtered.add(record);

        }

        return filtered;

    }

    public List<SObject> byEmpty (List<SObject> records, String fieldName) { 

        List<SObject> filtered = new List<SObject>();

        for (SObject record : records ) {

            String value = (String) SObjects.getFieldValue(record, fieldName);

            if ( String.isNotEmpty(value) ) continue;

            filtered.add(record);

        }

        return filtered;

    }

    public List<SObject> withError (List<SObject> records) {

        List<SObject> filtered = new List<SObject>();

        for (SObject record : records ) {

            if ( !record.hasErrors() ) continue;

            filtered.add(record);

        }

        return filtered;

    }

    public Boolean hasError (List<SObject> records) {

        for (SObject record : records ) {

            if ( record.hasErrors() ) return true;
            
        }

        return false;

    }


}