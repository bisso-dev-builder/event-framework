public interface HttpPayloadInjector {

    HttpRequest injectPayload (Object payload, HttpRequest request);

}