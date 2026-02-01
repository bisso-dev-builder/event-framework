public class InterceptorFactory {

	//TODO THINK INTO CACHE FEATURE
	public static Map<String, TriggerInterceptor> cache = new Map<String, TriggerInterceptor>();
    
    public static TriggerInterceptor newInstance (String className) {        
		return  (TriggerInterceptor) TypeFactory.newInstance (className, TriggerInterceptor.class );
    }

}