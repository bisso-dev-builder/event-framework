@isTest(isParallel=true)
public class LoggerTest {
    @isTest
    static void shouldReturnSingletonInstance() {
        Logger firstInstance = Logger.getLogger();
        Logger secondInstance = Logger.getLogger();

        Assert.isNotNull(firstInstance);
        Assert.areEqual(firstInstance, secondInstance);
    }

    @isTest
    static void shouldUseDefaultAdapterWhenNoAdapterIsProvided() {
        Logger logger = Logger.getLogger();

        Assert.isNotNull(logger);
        Assert.isNotNull(logger.adapter);
        Assert.isInstanceOfType(logger.adapter, DefaultLoggerAdapter.class);
    }

    @isTest
    static void shouldUseProvidedAdapterWhenCreatingLoggerInstance() {
        LoggerFixtureFactory.FakeLoggerAdapter fakeAdapter = LoggerFixtureFactory.newFakeLoggerAdapter();

        Logger logger = Logger.getLogger(fakeAdapter);

        Assert.isNotNull(logger);
        Assert.areEqual(fakeAdapter, logger.adapter);
    }

    @isTest
    static void shouldNotOverrideExistingInstanceWhenGetLoggerWithAdapterIsCalled() {
        Logger firstLogger = Logger.getLogger();
        ILogger originalAdapter = firstLogger.adapter;

        LoggerFixtureFactory.FakeLoggerAdapter newAdapter = LoggerFixtureFactory.newFakeLoggerAdapter();
        Logger secondLogger = Logger.getLogger(newAdapter);

        Assert.areEqual(firstLogger, secondLogger);
        Assert.areEqual(originalAdapter, secondLogger.adapter);
    }

    @isTest
    static void shouldLogInfoMessageWithStringOverload() {
        LoggerFixtureFactory.FakeLoggerAdapter fakeAdapter = LoggerFixtureFactory.newFakeLoggerAdapter();
        Logger logger = Logger.getLogger(fakeAdapter);

        String message = 'Test info message';

        logger.log(message);

        Assert.areEqual(1, fakeAdapter.logs.size());
        Log logged = fakeAdapter.logs[0];

        Assert.isNotNull(logged);
        Assert.areEqual(message, logged.getMessage());
        Assert.areEqual(LoggingLevel.INFO, logged.getLevel());
    }

    @isTest
    static void shouldLogInfoMessageWithPayload() {
        LoggerFixtureFactory.FakeLoggerAdapter fakeAdapter = LoggerFixtureFactory.newFakeLoggerAdapter();
        Logger logger = Logger.getLogger(fakeAdapter);

        String message = 'Test info with payload';
        Map<String, Object> payload = new Map<String, Object>{
            'key' => 'value',
            'number' => 10
        };

        logger.log(message, payload);

        Assert.areEqual(1, fakeAdapter.logs.size());
        Log logged = fakeAdapter.logs[0];

        Assert.isNotNull(logged);
        Assert.areEqual(message, logged.getMessage());
        Assert.areEqual(LoggingLevel.INFO, logged.getLevel());
        Assert.isNotNull(logged.getParameters());
        Assert.areEqual(payload.size(), logged.getParameters().size());
        Assert.areEqual(payload.get('key'), logged.getParameters().get('key'));
        Assert.areEqual(payload.get('number'), logged.getParameters().get('number'));
    }

    @isTest
    static void shouldLogErrorMessageWithoutException() {
        LoggerFixtureFactory.FakeLoggerAdapter fakeAdapter = LoggerFixtureFactory.newFakeLoggerAdapter();
        Logger logger = Logger.getLogger(fakeAdapter);

        String message = 'Error message';

        logger.error(message);

        Assert.areEqual(1, fakeAdapter.logs.size());
        Log logged = fakeAdapter.logs[0];

        Assert.isNotNull(logged);
        Assert.areEqual(message, logged.getMessage());
        Assert.areEqual(LoggingLevel.ERROR, logged.getLevel());
        Assert.isNull(logged.getExceptionInfo());
    }

    @isTest
    static void shouldLogErrorMessageWithException() {
        LoggerFixtureFactory.FakeLoggerAdapter fakeAdapter = LoggerFixtureFactory.newFakeLoggerAdapter();
        Logger logger = Logger.getLogger(fakeAdapter);

        String message = 'Error with exception';
        Exception captured;

        try {
            Integer i = 1 / 0;
        } catch (Exception e) {
            captured = e;
        }

        logger.error(message, captured);

        Assert.areEqual(1, fakeAdapter.logs.size());
        Log logged = fakeAdapter.logs[0];

        Assert.isNotNull(logged);
        Assert.areEqual(message, logged.getMessage());
        Assert.areEqual(captured, logged.getExceptionInfo());
    }

    @isTest
    static void shouldLogErrorMessageWithExceptionAndPayload() {
        LoggerFixtureFactory.FakeLoggerAdapter fakeAdapter = LoggerFixtureFactory.newFakeLoggerAdapter();
        Logger logger = Logger.getLogger(fakeAdapter);

        String message = 'Error with exception and payload';
        Exception captured;

        try {
            Integer i = 1 / 0;
        } catch (Exception e) {
            captured = e;
        }

        Map<String, Object> payload = new Map<String, Object>{
            'context' => 'unit-test'
        };

        logger.error(message, captured, payload);

        Assert.areEqual(1, fakeAdapter.logs.size());
        Log logged = fakeAdapter.logs[0];

        Assert.isNotNull(logged);
        Assert.areEqual(message, logged.getMessage());
        Assert.areEqual(captured, logged.getExceptionInfo());
        Assert.isNotNull(logged.getParameters());
        Assert.areEqual(payload.get('context'), logged.getParameters().get('context'));
    }

    @isTest
    static void shouldLogDebugMessage() {
        LoggerFixtureFactory.FakeLoggerAdapter fakeAdapter = LoggerFixtureFactory.newFakeLoggerAdapter();
        Logger logger = Logger.getLogger(fakeAdapter);

        String message = 'Debug message';

        logger.debug(message);

        Assert.areEqual(1, fakeAdapter.logs.size());
        Log logged = fakeAdapter.logs[0];

        Assert.isNotNull(logged);
        Assert.areEqual(message, logged.getMessage());
        Assert.areEqual(LoggingLevel.DEBUG, logged.getLevel());
    }

    @isTest
    static void shouldLogWarnMessage() {
        LoggerFixtureFactory.FakeLoggerAdapter fakeAdapter = LoggerFixtureFactory.newFakeLoggerAdapter();
        Logger logger = Logger.getLogger(fakeAdapter);

        String message = 'Warn message';

        logger.warn(message);

        Assert.areEqual(1, fakeAdapter.logs.size());
        Log logged = fakeAdapter.logs[0];

        Assert.isNotNull(logged);
        Assert.areEqual(message, logged.getMessage());
        Assert.areEqual(LoggingLevel.WARN, logged.getLevel());
    }

    @isTest
    static void shouldDelegateLogObjectDirectlyToAdapter() {
        LoggerFixtureFactory.FakeLoggerAdapter fakeAdapter = LoggerFixtureFactory.newFakeLoggerAdapter();
        Logger logger = Logger.getLogger(fakeAdapter);

        Log inputLog = new Log()
            .level(LoggingLevel.INFO)
            .message('Direct log instance');

        logger.log(inputLog);

        Assert.areEqual(1, fakeAdapter.logs.size());
        Log logged = fakeAdapter.logs[0];

        Assert.areEqual(inputLog, logged);
    }
}