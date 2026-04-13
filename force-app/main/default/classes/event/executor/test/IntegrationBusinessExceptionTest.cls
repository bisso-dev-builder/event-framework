@isTest
public class IntegrationBusinessExceptionTest {

    @isTest
    static void shouldCreateExceptionWithCodeMessageAndDetail() {
        // Given
        String code = 'ERR001';
        String message = 'Something went wrong';
        String detail = 'Detailed description of the error';

        // When
        IntegrationBusinessException ex = new IntegrationBusinessException(code, message, detail);

        // Then
        Assert.isTrue(ex.getMessage().contains(code), 'Message should contain the code');
        Assert.isTrue(ex.getMessage().contains(message), 'Message should contain the message');
        Assert.isTrue(ex.getMessage().contains(detail), 'Message should contain the detail');
    }

}
