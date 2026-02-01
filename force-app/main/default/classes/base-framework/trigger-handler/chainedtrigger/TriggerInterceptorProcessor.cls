public virtual class TriggerInterceptorProcessor {

    private String objectName;

    private String triggerOperation; 

    private TriggerInterceptorRepository repository;

    public TriggerInterceptorProcessor(String objectName, String triggerOperation) {
        this ( new TriggerInterceptorRepository() );
        this.objectName = objectName;
        this.triggerOperation = triggerOperation;
    }

    public TriggerInterceptorProcessor(TriggerInterceptorRepository repository) {
        this.repository = repository;
    }

    virtual
    public void process () {

        List<ChainedTriggerInterceptor__mdt> interceptorConfigs = findInterceptors ();

        for (ChainedTriggerInterceptor__mdt config : interceptorConfigs ) {
            process( new TriggerInterceptorConfig(config));
        }

    }

    private void process ( TriggerInterceptorConfig config ) {
        
        TriggerInterceptor interceptor = getInterceptor ( config );



    }

    private List<ChainedTriggerInterceptor__mdt> findInterceptors () {
        return repository.findByObjectAndTriggerEvent (objectName, triggerOperation);
    }


    private TriggerInterceptor getInterceptor ( TriggerInterceptorConfig config ) {

        TriggerInterceptor interceptor =  InterceptorFactory.newInstance (config.getInterceptorClass());

        if (interceptor == null) throw new InvalidChainedTriggerConfigurationException ('Invalid Chained Trigger Configuration for ' + config );

        return interceptor;

    }

    private TriggerFilter getFilter ( TriggerInterceptorConfig config ) {

        return TriggerFilterFactory.newInstance (config.getTriggerFilterClass());

    }

	public class InvalidChainedTriggerConfigurationException extends Exception {}


}