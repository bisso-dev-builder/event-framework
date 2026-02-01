
public virtual class TriggerInterceptorRepository {
    
    virtual
    public List<ChainedTriggerInterceptor__mdt> findByObjectAndTriggerEvent (String objectName, String operationType) {

        return [ SELECT DeveloperName, ObjectName__c, Sequence__c, TriggerFilterName__c 
                FROM ChainedTriggerInterceptor__mdt
                WHERE ObjectName__c = :objectName
                AND TriggerOperationType__c =: operationType
                ORDER BY Sequence__c ASC
            ];
    }

}