public class TriggerFilterFactory {

	public static TriggerFilter newInstance (String className) {
		return  (TriggerFilter) TypeFactory.newInstance (className, TriggerFilter.class );
	}

}