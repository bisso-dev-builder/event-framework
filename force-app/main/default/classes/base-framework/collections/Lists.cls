/**
 * @author eduardo.bisso - dev-builder
 */
public class Lists {

    public static List<String> toIds ( List<SObject> records ) {        
        return pullField (records, 'Id');
    }

    public static Set<Id> toSetIds ( List<SObject> records ) {        
        return toSetIds ( toIds (records) );
    }

    public static Set<Id> toSetIds ( List<String> ids  ) {
    
        Set<Id> filtered = new Set<Id>();
        
        for ( String id : ids  ) {
            filtered.add ( id );
        }
        
        return filtered;
    }

    public static List<String> pullField (  List<SObject> records, String fieldName ) {
        
        if ( isEmpty( records ) ) return new List<String>();
    
        Set<String> filtered = new Set<String>();
        
        for ( SObject record : records  ) {

            Object fieldValue = SObjects.getFieldValue(record, fieldName);

            if ( fieldValue == null ) continue;
            
            filtered.add ( '' + fieldValue );
        }        
        
        return new List<String> ( filtered );
    }
    
    public static List<SObject> pullAllSubQueryRecords (List<SObject> records, String subQueryName) {

        if ( isEmpty( records ) ) return new List<SObject>();

        List<SObject> allRecords;

        for ( SObject record : records ) {

            if ( record.getSObjects(subQueryName) == null ) continue;

            List<SObject> subRecords = record.getSObjects(subQueryName);

            if (subRecords.isEmpty()) continue;

            if ( allRecords == null ) allRecords = SObjects.newEmptyList(subRecords);

            allRecords.addAll ( subRecords );

        }

        return allRecords;

    }

    public static Boolean isEmpty (List<SObject> records) {
        return records == null || records.isEmpty();
    }

    public static Boolean isEmpty (List<Object> records) {
        return records == null || records.isEmpty();
    }

    public static Boolean isNotEmpty (List<Object> records) {
        return !isEmpty (records);
    }

    public static List<Object> removeDuplicateLines(List<Object> records) {
        Set<Object> recordsSet = new Set<Object>(records);
        return new List<Object>(recordsSet);
    }

    public static List<Object> removeEmptyLines(List<Object> records) {
        Set<Object> recordsSet = new Set<Object>(records);
        recordsSet.remove('');
        recordsSet.remove(null);
        return new List<Object>(recordsSet);
    }

    public static SObject getFirstOrNull (List<SObject> records) {
        return Lists.isNotEmpty(records) ? records.get(0) : null;
    }
    
}