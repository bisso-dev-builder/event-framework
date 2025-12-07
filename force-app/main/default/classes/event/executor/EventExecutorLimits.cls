public class EventExecutorLimits {

    public static final Integer FUTURE_CALL_SIZE = 5;
    public static final Integer FUTURE_CALL_LIMIT = 45;
    public static final Integer REPROCESS_CHUCK_SIZE = 40 * FUTURE_CALL_SIZE;
    public static final Integer TOTAL_RECORDS_IN_FUTURE = FUTURE_CALL_SIZE * FUTURE_CALL_LIMIT;

}