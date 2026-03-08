@isTest (isParallel=true)
public class DefaultLoggerAdapterTest {

    private class TestableDefaultLoggerAdapter extends DefaultLoggerAdapter {
        public LoggingLevel capturedLevel;
        public String capturedMessage;

        override
        public void log(LoggingLevel level, String message) {
            capturedLevel = level;
            capturedMessage = message;
        }

        public String exposeStackInfo() {
            return getCurrentStackInfo();
        }
    }

    @isTest
    static void shouldBuildLogMessageAndDelegateToLogWithLevelAndMessage() {
        TestableDefaultLoggerAdapter adapter = new TestableDefaultLoggerAdapter();

        Log log = new Log().exception( new MockException('Test message') ).addParameter('key', 'value');

        String expectedStackInfo = adapter.exposeStackInfo();
        String expectedMessage = expectedStackInfo + ' - ' + log.getMessage();
        expectedMessage += '\n' + log.getParameterAsString();
        expectedMessage += '\n' + log.getExceptionMessageAndStackTrace();

        adapter.log(log);

        Assert.areEqual(log.getLevel(), adapter.capturedLevel);
        Assert.areEqual(expectedMessage, adapter.capturedMessage);
    }

    @isTest
    static void shouldGetCurrentStackInfoReturnNonEmptyString() {
        TestableDefaultLoggerAdapter adapter = new TestableDefaultLoggerAdapter();

        String stackInfo = adapter.exposeStackInfo();

        Assert.isNotNull(stackInfo);
        Assert.isTrue(stackInfo.contains('DefaultLoggerAdapter'));
    }

    @isTest
    static void shouldLogUsingLoggingLevelAndMessage() {

        DefaultLoggerAdapter adapter = new DefaultLoggerAdapter();

        adapter.log(LoggingLevel.INFO, 'Simple message');

        Assert.isTrue(true);
    }

    public class MockException extends Exception {}

}