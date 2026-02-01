public class TriggerInterceptorConfig {

    String objectName;

    String interceptorClass;

    String triggerFilterClass;

    String triggerOperation;

    Integer sequence;

    public TriggerInterceptorConfig() {
        this.sequence = 0;
    }

    public TriggerInterceptorConfig(ChainedTriggerInterceptor__mdt config) {
        objectName (config.ObjectName__c)
        .interceptorClass(config.InterceptorClass__c )
        .sequence(config.Sequence__c)
        .triggerOperation ( config.TriggerOperationType__c)
        .triggerFilterClass ( config.TriggerFilterName__c );
    }

    public String getObjectName() {
        return this.objectName;
    }

    public String getInterceptorClass() {
        return this.interceptorClass;
    }

    public String getTriggerFilterClass() {
        return this.triggerFilterClass;
    }

    public String getTriggerOperation() {
        return this.triggerOperation;
    }

    public Integer getSequence() {
        return this.sequence;
    }

    public TriggerInterceptorConfig objectName(String objectName) {
        this.objectName = objectName;
        return this;
    }

    public TriggerInterceptorConfig interceptorClass(String interceptorClass) {
        this.interceptorClass = interceptorClass;
        return this;
    }

    public TriggerInterceptorConfig triggerFilterClass(String triggerFilterClass) {
        this.triggerFilterClass = triggerFilterClass;
        return this;
    }

    public TriggerInterceptorConfig triggerOperation(String triggerOperation) {
        this.triggerOperation = triggerOperation;
        return this;
    }

    public TriggerInterceptorConfig sequence(Decimal sequence) {
        this.sequence = sequence.intValue();
        return this;
    }

    override
    public String toString () {
        return JSON.serialize(this);
    }

}