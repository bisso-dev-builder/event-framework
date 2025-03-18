@isTest
public class HttpMock implements HttpCalloutMock {

    HttpResponse response;

    public HttpMock() {
        this.response = new HttpResponse();
        init(200, '{"message":"success"}');
    }

    public HttpMock(String payload) {
        this();
        this.response.setBody(payload);
    }


    public void init (Integer statusCode, String payload) {
        this.response.setStatusCode( statusCode );
        this.response.setBody(payload);
    }

    public HttpResponse respond(HttpRequest request) {
        return response;
    }

}