@isTest
public class HttpRequestUrlBinderFixtureFactory {

    public static Map<String, String> newRequestPayload() {
        Map<String, String> payload = new Map<String, String>();
        payload.put('id', '12345');
        payload.put('name', 'TestName');
        return payload;
    }

    public static String newUrlTemplate() {
        return 'https://api.example.com/resource/{!id}/details/{!name}';
    }

    public static String expectedBindedUrl() {
        return 'https://api.example.com/resource/12345/details/TestName';
    }
}