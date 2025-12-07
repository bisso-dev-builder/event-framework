public class EventConfigurationFilter {
    
    public Map<String, EventConfiguration> indexByName (List<EventConfiguration> configs) {

        Map<String, EventConfiguration> indexedConfigs = new Map<String, EventConfiguration> ();


        for (EventConfiguration config: configs) {

            indexedConfigs.put ( config.getEventName() , config );

        }

        return indexedConfigs;

    }

}