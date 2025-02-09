/**
 * @author eduardo.bisso - dev-builder
 */
public class Maps {

<<<<<<< HEAD

=======
>>>>>>> db231ee1d3249d723cb7ec4e62aba8ed87a280c1
    public static Map<String, SObject> indexBy ( String fieldName
                                                , List<SObject> records  ) {
                                                                    
        if ( Lists.isEmpty(records) ) return new Map<String, SObject>();
        
        Map<String, SObject> values = SObjects.newEmptyMap(records);
        
        for ( SObject record : records  ) {
        
            String value = (String) SObjects.getFieldValue(record, fieldName);
            
<<<<<<< HEAD
            if ( value == null || values.containsKey (value)) continue;          
            
            values.put ( value, record );

=======
            if ( value == null ) continue;
            
            values.put ( value, record );
>>>>>>> db231ee1d3249d723cb7ec4e62aba8ed87a280c1
        }
        
        return values;
    }
<<<<<<< HEAD
      
=======

>>>>>>> db231ee1d3249d723cb7ec4e62aba8ed87a280c1
    public static Map<String, List<SObject>> grouppBy ( String fieldName
                                                     , List<SObject> records  ) {
                                                                
        if ( Lists.isEmpty(records) ) return new Map<String, List<SObject>>();

        Map<String, List<SObject>> groupedRecords = SObjects.newEmptyGroupedMap (records);
        
        String objectName = SObjects.getObjectName(records);                                                        

        for ( SObject record : records  ) {
        
<<<<<<< HEAD
            String value = (String) SObjects.getFieldValue(record, fieldName);
=======
            String value = (String) SObjects.getFieldValue (record, fieldName);
>>>>>>> db231ee1d3249d723cb7ec4e62aba8ed87a280c1
            
            if ( String.isEmpty(value)) continue;
            
            if ( groupedRecords.get ( value ) == null ) groupedRecords.put ( value, SObjects.newEmptyList(objectName) );
            
            groupedRecords.get ( value ).add ( record );
        }
        
        return groupedRecords;
    }
<<<<<<< HEAD
=======

>>>>>>> db231ee1d3249d723cb7ec4e62aba8ed87a280c1
}