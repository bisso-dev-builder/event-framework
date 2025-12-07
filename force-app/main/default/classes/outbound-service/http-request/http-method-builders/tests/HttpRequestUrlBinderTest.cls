
@isTest
public class HttpRequestUrlBinderTest {

    @isTest
    static void shouldBindUrlCorrectly() {

        String urlTemplate = HttpRequestUrlBinderFixtureFactory.newUrlTemplate();
        Map<String, String> requestPayload = HttpRequestUrlBinderFixtureFactory.newRequestPayload();
        String expectedUrl = HttpRequestUrlBinderFixtureFactory.expectedBindedUrl();

        String bindedUrl = HttpRequestUrlBinder.bind(urlTemplate, requestPayload);

        System.assertEquals(expectedUrl, bindedUrl, 'A URL deve ser vinculada corretamente com os valores do payload.');
    }

    // Teste para verificar o comportamento com chaves ausentes no payload
    @isTest
    static void shouldNotReplaceMissingKeys() {
        // Dado (Given)
        String urlTemplate = 'https://api.example.com/resource/{!id}/details/{!missingKey}';
        Map<String, String> requestPayload = HttpRequestUrlBinderFixtureFactory.newRequestPayload();
        String expectedUrl = 'https://api.example.com/resource/12345/details/{!missingKey}';

        // Quando (When)
        String bindedUrl = HttpRequestUrlBinder.bind(urlTemplate, requestPayload);

        // Então (Then)
        System.assertEquals(expectedUrl, bindedUrl, 'A URL deve manter as chaves ausentes sem substituição.');
    }

    // Teste para verificar o comportamento com payload vazio
    @isTest
    static void shouldReturnOriginalUrlWhenPayloadIsEmpty() {
        // Dado (Given)
        String urlTemplate = HttpRequestUrlBinderFixtureFactory.newUrlTemplate();
        Map<String, String> emptyPayload = new Map<String, String>();
        String expectedUrl = urlTemplate;

        // Quando (When)
        String bindedUrl = HttpRequestUrlBinder.bind(urlTemplate, emptyPayload);

        // Então (Then)
        System.assertEquals(expectedUrl, bindedUrl, 'A URL original deve ser retornada quando o payload estiver vazio.');
    }
}