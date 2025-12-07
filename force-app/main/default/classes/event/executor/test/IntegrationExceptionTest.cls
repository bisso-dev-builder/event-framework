@isTest
public class IntegrationExceptionTest {
    
    public static HttpResponse newHttpResponse(Integer statusCode, String responseBody) {
        HttpResponse response = new HttpResponse();
        response.setStatusCode(statusCode);
        response.setBody(responseBody);
        return response;
    }

    public static IntegrationException newIntegrationException(Integer statusCode, String responseBody) {
        HttpResponse response = newHttpResponse(statusCode, responseBody);
        return new IntegrationException(response);
    }


    @isTest
    static void shouldGenerateCorrectExceptionMessage() {
        // Arrange
        Integer statusCode = 400;
        String responseBody = '{"error": "Invalid request"}';
        HttpResponse response = newHttpResponse(statusCode, responseBody);

        // Act
        IntegrationException integrationException = new IntegrationException(response);

        // Assert
        String expectedMessage = statusCode + ' | ' + responseBody;
        System.assertEquals(expectedMessage, integrationException.getMessage(), 'A mensagem da exceção deve ser gerada corretamente.');
    }

    @isTest
    static void shouldStoreResponseBodyCorrectly() {
 
        Integer statusCode = 500;
        String responseBody = '{"error": "Internal server error"}';
        IntegrationException integrationException = newIntegrationException(statusCode, responseBody);

        String actualResponseBody = integrationException.getResponseBody();

        System.assertEquals(responseBody, actualResponseBody, 'O corpo da resposta deve ser armazenado corretamente.');
    }
}