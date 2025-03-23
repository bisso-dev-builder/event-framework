public class IntegrationException extends Exception {

    String responseBody;

    public IntegrationException(HttpResponse response) {
        this( response.getStatusCode() + ' | ' + response.getBody() );
        this.responseBody = response.getBody();
    }

    public String getResponseBody() {
        return responseBody;
    }
}