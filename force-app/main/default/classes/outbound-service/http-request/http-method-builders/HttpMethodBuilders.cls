public class HttpMethodBuilders {
    
    static Map<String, HttpPayloadInjector> builders;

    static {
        loadBuilders();
    }

    public static HttpPayloadInjector get (String method) {
        return builders.get (method);
    }

    static void loadBuilders() {

        if (builders != null) return;

        builders = new Map<String, HttpPayloadInjector> {
            'GET' => new HttpQueryStringBuilder(),
            'POST' => new HttpPostBuilder(),
            'PATCH' => new HttpRestBodyBuilder(),
            'DELETE' => new HttpQueryStringBuilder()
        };
    }

}