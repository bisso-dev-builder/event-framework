@isTest
public class LoggerFixtureFactory {

    public class FakeLoggerAdapter implements ILogger {
        public List<Log> logs = new List<Log>();

        public void log(Log log) {
            logs.add(log);
        }
    }

    public static FakeLoggerAdapter newFakeLoggerAdapter() {
        return new FakeLoggerAdapter();
    }

    public static Logger newLogger() {
        FakeLoggerAdapter adapter = newFakeLoggerAdapter();
        return newLogger (adapter);
    }

    public static Logger newLogger(ILogger adapter) {
        return Logger.getLogger(adapter);
    }
}