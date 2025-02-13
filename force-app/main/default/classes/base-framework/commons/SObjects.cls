/**
 * Add Cristian Biral - SObjectNavigator Code
 * @author eduardo.bisso - dev-builder
 */
public class SObjects {

    static final Map<String, Schema.SObjectType> describer = Schema.getGlobalDescribe();

    public static Schema.SObjectType getObjectType (String objectName) {
        return describer.get(objectName);
    }

    public static Map<String, Schema.SObjectField> getObjectFields (String objectName) {

        return getObjectType(objectName).getDescribe().fields.getMap();
 
    }

    public static Object getFieldValue(SObject record, String fieldName) {

        if (record == null) return null;

        List<String> properties = fieldName.split('\\.', 2);

        if (properties.size() > 1) {

            SObject recordProperty = record.getSObject(properties.get(0));

            String nextDeepFieldName = properties.get(1);

            return getFieldValue(recordProperty, nextDeepFieldName);

        }

        return record.get(fieldName);

    }

    public static SObject newInstance ( String objectName ) {
        Type objectType = Type.forName (objectName);
        return (SObject) objectType.newInstance();
    }

    public static List<SObject> newEmptyList ( String objectName ) {
        if (objectName == null) return new List<SObject>();
        Type listType = Type.forName ('List<'+ objectName +'>');
        return (List<SObject>) listType.newInstance();
    }

    public static String getObjectName (List<SObject> records) {
        if (records == null || records.isEmpty()) return null;
        return getObjectName(records.get(0));
    }
    
    public static List<SObject> newEmptyList (List<SObject> records) {
        
        if (records == null || records.isEmpty()) return records;

        String objectName = getObjectName(records);
        
        if (objectName == null) return null;

        return newEmptyList(objectName);
    }

    public static String getObjectName (SObject record) {

        if (record == null) return null;

        return record.getSObjectType().getDescribe().getName();
    }

    public static Map<String,SObject> newEmptyMap (List<SObject> records) {

        String objectName = getObjectName(records);

        if ( objectName == null ) return null;
              
        return newEmptyMap ( records , Type.forName(objectName) );       

    }

    public static Map<String,SObject> newEmptyMap (List<SObject> records, Type objecType) {
    
        Type sObjectType = Type.forName ( 'Map<String,' + objecType.getName() + '>' );
        
        return ( Map<String, SObject> ) sObjectType.newInstance();        

    }


    public static Map<String,List<SObject>> newEmptyGroupedMap (List<SObject> records) {

        String objectName = getObjectName(records);

        if ( objectName == null ) return null;
      
        Type sObjectType = Type.forName ( 'Map<String, List<' + objectName + '>>' );
        
        return ( Map<String, List<SObject>> ) sObjectType.newInstance();        

    }


}