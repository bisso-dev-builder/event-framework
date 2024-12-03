/**
 * @author eduardo.bisso - dev-builder
 */
public class Maps {

    public static Map<String, SObject> indexBy ( String fieldName
                                                , List<SObject> records  ) {
                                                                    
        if ( Lists.isEmpty(records) ) return new Map<String, SObject>();
        
        Map<String, SObject> values = SObjects.newEmptyMap(records);
        
        for ( SObject record : records  ) {
        
            String value = (String) SObjects.getFieldValue(record, fieldName);
            
            if ( value == null ) continue;
            
            values.put ( value, record );
        }
        
        return values;
    }

    public static Map<String, List<SObject>> grouppBy ( String fieldName
                                                     , List<SObject> records  ) {
                                                                
        if ( Lists.isEmpty(records) ) return new Map<String, List<SObject>>();

        Map<String, List<SObject>> groupedRecords = SObjects.newEmptyGroupedMap (records);
        
        String objectName = SObjects.getObjectName(records);                                                        

        for ( SObject record : records  ) {
        
            String value = (String) SObjects.getFieldValue (record, fieldName);
            
            if ( String.isEmpty(value)) continue;
            
            if ( groupedRecords.get ( value ) == null ) groupedRecords.put ( value, SObjects.newEmptyList(objectName) );
            
            groupedRecords.get ( value ).add ( record );
        }
        
        return groupedRecords;
    }

}