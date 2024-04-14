/**
 * @author eduardo.bisso - dev-builder
 */
public class SObjectMapper {

    public static List<SObject> applyMasterRecord ( SObject masterRecord
                                    , String lookupFieldName
                                    , List<SObject> records ) {
                                        
        for (SObject record : records ) {

            Id lookupId = (Id) record.get(lookupFieldName);

            if (lookupId != null) continue;

            record.put (lookupFieldName, masterRecord.Id);    

        }

        return records;

    }

}