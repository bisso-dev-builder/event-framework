@isTest
public class EventConfigurationFilterTest {

    @isTest
    static void shouldIndexEventConfigurationsByName() {
        // Given: Criar uma lista de EventConfigurations
        List<String> eventNames = new List<String>{'EventA', 'EventB', 'EventC'};
        List<EventConfiguration> eventConfigs = EventConfigurationFixtureFactory.newEventConfigurations(eventNames);

        // When: Invocar o método indexByName
        EventConfigurationFilter filter = new EventConfigurationFilter();
        Map<String, EventConfiguration> indexedConfigs = filter.indexByName(eventConfigs);

        // Then: Verificar se os eventos foram indexados corretamente
        System.assertEquals(eventNames.size(), indexedConfigs.size(), 'O número de eventos indexados deve ser igual ao número de eventos criados.');

        for (String eventName : eventNames) {
            System.assert(indexedConfigs.containsKey(eventName), 'O mapa deve conter o evento: ' + eventName);
            System.assertEquals(eventName, indexedConfigs.get(eventName).getEventName(), 'O evento indexado deve ter o nome correto.');
        }
    }

    @isTest
    static void shouldHandleEmptyList() {
        // Given: Uma lista vazia de EventConfigurations
        List<EventConfiguration> emptyList = new List<EventConfiguration>();

        // When: Invocar o método indexByName
        EventConfigurationFilter filter = new EventConfigurationFilter();
        Map<String, EventConfiguration> indexedConfigs = filter.indexByName(emptyList);

        // Then: Verificar se o mapa retornado está vazio
        System.assertEquals(0, indexedConfigs.size(), 'O mapa deve estar vazio quando a lista de entrada está vazia.');
    }
}