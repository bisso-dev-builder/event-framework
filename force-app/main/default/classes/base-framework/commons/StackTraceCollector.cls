public class StackTraceCollector {


    public static StackTraceInfo getCurrentStack() {
        return getStackTrace().get(0);
    }

    public static List<StackTraceInfo> getStackTrace() {

        List<String> stackTrace = new DmlException('_').getStackTraceString().split('\n');

        List<StackTraceInfo> stack = new List<StackTraceInfo>();

        for (Integer i = 1; i < stackTrace.size(); i++) {
            if (!stackTrace[i].contains('Class.' + StackTraceCollector.class + '.')) {
                stack.add(new StackTraceInfo(stackTrace[i]));
            }
        }

        return stack;
    }

    public class StackTraceInfo {

        public String apexClass;
        public String method;
        public Integer line;
        public Integer column;

        private StackTraceInfo(String line) {
            String apexClassMethod = line.substringAfter('Class.').substringBefore(':');
            this.apexClass = apexClassMethod.substringBeforeLast('.');
            this.method = apexClassMethod.substringAfterLast('.');
            this.line = Integer.valueOf(line.substringBetween('line ', ','));
            this.column = Integer.valueOf(line.substringAfter('column '));
        }

        override
        public String toString () {
            return '[ ' + this.apexClass + ' | ' + method + ' : ' + line + ', ' + column + ' ] ';
        }
    }
	
}