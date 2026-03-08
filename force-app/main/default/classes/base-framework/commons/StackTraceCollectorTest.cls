@isTest
public class StackTraceCollectorTest {

    @isTest
    static void shouldCollectAndParseStackTrace() {
        List<StackTraceCollector.StackTraceInfo> stack =
            StackTraceCollector.getStackTrace();

        System.assertNotEquals(0, stack.size(), 'Stack should not be empty');

        StackTraceCollector.StackTraceInfo first = stack[0];

        Assert.isNotNull( first.apexClass, 'apexClass should not be null');
        Assert.isNotNull( first.method, 'method should not be null');
        Assert.isNotNull( first.line, 'line should not be null');
        Assert.isNotNull( first.column, 'column should not be null');

        System.assertEquals('StackTraceCollectorTest', first.apexClass,
            'Expected first frame to be this test class');
        System.assertEquals('shouldCollectAndParseStackTrace', first.method,
            'Expected first frame to be this test method');

        String formatted = first.toString();
        Assert.isTrue(formatted.startsWith('['), 'toString should start with [');
        Assert.isTrue(formatted.contains('|'), 'toString should contain |');
        Assert.isTrue(formatted.contains(':'), 'toString should contain :');
        Assert.isTrue(formatted.contains(','), 'toString should contain ,');
        Assert.isTrue(formatted.endsWith(' ] '), 'toString should end with  ], but ' + formatted);
    }

    @isTest
    static void shouldNotIncludeStackTraceCollectorFrames() {
        List<StackTraceCollector.StackTraceInfo> stack =
            StackTraceCollector.getStackTrace();

        for (StackTraceCollector.StackTraceInfo info : stack) {
            System.assertNotEquals(
                'StackTraceCollector',
                info.apexClass,
                'Collector frames must be filtered from result'
            );
        }
    }
}