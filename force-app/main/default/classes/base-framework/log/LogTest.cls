@isTest(isParallel=true)
public class LogTest {

    static Log newDefaultLog () {
        return new Log();
    }

    @isTest
    static void shouldInitializeWithDefaultValues() {
        Log log = newDefaultLog();

        Assert.isNull(log.getTag());
        Assert.isNull(log.getMessage());
        Assert.isNull(log.getExceptionInfo());
        Assert.areEqual(LoggingLevel.INFO, log.getLevel());
        Assert.isNotNull(log.getParameters());
        Assert.isTrue(log.getParameters().isEmpty());
        Assert.isFalse(log.hasError());
        Assert.areEqual('', log.getErrorMessage());
        Assert.areEqual('', log.getParameterAsString());
        Assert.areEqual('', log.getExceptionMessageAndStackTrace());
    }

    @isTest
    static void shouldSetTagMessageAndLevel() {
        String tag = 'UNIT_TEST';
        String message = 'Test message';
        LoggingLevel level = LoggingLevel.DEBUG;

        Log log = newDefaultLog()
            .tag(tag)
            .message(message)
            .level(level);

        Assert.areEqual(tag, log.getTag());
        Assert.areEqual(message, log.getMessage());
        Assert.areEqual(level, log.getLevel());
    }

    @isTest
    static void shouldSetExceptionAndChangeLevelToError() {
        Exception ex = new MockException('Generic error');

        Log log = newDefaultLog()
            .level(LoggingLevel.WARN)
            .exception(ex);

        Assert.isTrue(log.hasError());
        Assert.areEqual(ex, log.getExceptionInfo());
        Assert.areEqual(LoggingLevel.ERROR, log.getLevel());
    }

    @isTest
    static void shouldReturnEmptyErrorMessageWhenNoException() {
        Log log = newDefaultLog();

        Assert.isFalse(log.hasError());
        Assert.areEqual('', log.getErrorMessage());
    }

    @isTest
    static void shouldReturnErrorMessageForGenericException() {
        String errorMessage = 'Generic exception message';
        Exception ex = new MockException(errorMessage);

        Log log = newDefaultLog().exception(ex);

        Assert.isTrue(log.hasError());
        Assert.areEqual(errorMessage, log.getErrorMessage());
    }

    @isTest
    static void shouldReturnDmlErrorMessageForDmlException() {
        DmlException dmlException;
        try {
            insert new Account();
        } catch (DmlException e) {
            dmlException = e;
        }

        Log log = newDefaultLog().exception(dmlException);

        String expectedMessage = dmlException.getDmlMessage(0);
        String actualMessage = log.getErrorMessage();

        Assert.isTrue(log.hasError());
        Assert.areEqual(expectedMessage, actualMessage);
    }

    @isTest
    static void shouldReturnEmptyParameterStringWhenNoParameters() {
        Log log = newDefaultLog();

        Assert.isTrue(log.getParameters().isEmpty());
        Assert.areEqual('', log.getParameterAsString());
    }

    @isTest
    static void shouldSerializeParametersToJsonWhenPresent() {

        Map<String, String> params = new Map<String, String>();

        Log log = newDefaultLog().parameters(  (Map<String, Object>) params).addParameter('key', 'value');

        Map<String, Object> parameters = log.getParameters();
        String expectedJson = JSON.serialize(parameters);
        String actualJson = log.getParameterAsString();

        Assert.isNotNull(parameters);
        Assert.isFalse(parameters.isEmpty());
        Assert.areEqual(expectedJson, actualJson);
    }

    @isTest
    static void shouldReturnEmptyExceptionMessageAndStackTraceWhenNoException() {
        Log log = newDefaultLog();

        Assert.isFalse(log.hasError());
        Assert.areEqual('', log.getExceptionMessageAndStackTrace());
    }

    @isTest
    static void shouldReturnExceptionMessageAndStackTraceWhenExceptionPresent() {
        String errorMessage = 'Exception with stack trace';
        Exception ex = new MockException(errorMessage);

        Log log = newDefaultLog().exception(ex);

        String result = log.getExceptionMessageAndStackTrace();

        Assert.isTrue(log.hasError());
        Assert.isTrue(result.contains(errorMessage));
        Assert.isTrue(result.contains('Stack Trace'));
    }

    @isTest
    static void shouldAddSingleParameterToMap() {
        Log log = newDefaultLog();

        String key = 'context';
        String value = 'unit-test';

        log.addParameter(key, value);

        Map<String, Object> parameters = log.getParameters();

        Assert.isNotNull(parameters);
        Assert.areEqual(1, parameters.size());
        Assert.areEqual(value, parameters.get(key));
    }

    @isTest
    static void shouldConcatenateMessagesWhenUsingLogListOverload() {
        List<String> messages = new List<String>{
            'Line 1',
            'Line 2',
            'Line 3'
        };

        Log log = newDefaultLog().log(messages);

        String expected = String.join(messages, '\n');
        String actual = log.getMessage();

        Assert.areEqual(expected, actual);
    }

    public class MockException extends Exception {}

}