/**
 * Based on 
 * https://github.com/kevinohara80/sfdc-trigger-framework
 * @author kevinohara80
 */
@SuppressWarnings('PMD')
public virtual class TriggerHandler {

    private static final Map<TriggerOperation, String> OPERATION_TYPE_LABEL = new Map<TriggerOperation, String>  {
        TriggerOperation.BEFORE_INSERT =>  'before insert'
        , TriggerOperation.BEFORE_UPDATE => 'before update'
        , TriggerOperation.BEFORE_DELETE => 'before delete'
        , TriggerOperation.AFTER_INSERT =>  'after insert'
        , TriggerOperation.AFTER_UPDATE =>  'after update'
        , TriggerOperation.AFTER_DELETE =>  'after delete'
        , TriggerOperation.AFTER_UNDELETE =>  'after undelete'
    };

    private static final Map<TriggerOperation, TriggerContext> OPERATION_TYPE_CONTEXT = new Map<TriggerOperation, TriggerContext>  {
        TriggerOperation.BEFORE_INSERT =>  TriggerContext.BEFORE_INSERT
        , TriggerOperation.BEFORE_UPDATE => TriggerContext.BEFORE_UPDATE
        , TriggerOperation.BEFORE_DELETE => TriggerContext.BEFORE_DELETE
        , TriggerOperation.AFTER_INSERT =>  TriggerContext.AFTER_INSERT
        , TriggerOperation.AFTER_UPDATE =>  TriggerContext.AFTER_UPDATE
        , TriggerOperation.AFTER_DELETE =>  TriggerContext.AFTER_DELETE
        , TriggerOperation.AFTER_UNDELETE =>   TriggerContext.AFTER_UNDELETE
    };

    // static map of handlername, times run() was invoked
    private static Map<String, LoopCount> loopCountMap;
    private static Set<String> bypassedHandlers;

    // the current context of the trigger, overridable in tests
    @TestVisible
    private Boolean isTriggerExecuting;

    // the current context of the trigger, overridable in tests
    @TestVisible
    protected TriggerContext context;
    
    protected Filter filter;

    // static initialization
    static {
        loopCountMap = new Map<String, LoopCount>();
        bypassedHandlers = new Set<String>();
    }

    // constructor
    public TriggerHandler() {
        this.setTriggerContext();
        this.filter = new Filter();
    }


    // main method that will be called during execution
    @SuppressWarnings('PMD')
    public void run() {

        if (!validateRun()) return;

        addToLoopCount();

        // dispatch to the correct handler method
        if (this.context == TriggerContext.BEFORE_INSERT) {

            this.validateBeforeInsert();
            this.beforeInsert();

        }   else if (this.context == TriggerContext.BEFORE_UPDATE) {

            this.validateBeforeUpdate();
            this.beforeUpdate();

        } else if (this.context == TriggerContext.BEFORE_DELETE) {

            this.beforeDelete();

        } else if (this.context == TriggerContext.AFTER_INSERT) {

            this.afterInsert();

        } else if (this.context == TriggerContext.AFTER_UPDATE) {

            this.afterUpdate();

        } else if (this.context == TriggerContext.AFTER_DELETE) {

            this.afterDelete();

        }   else if (this.context == TriggerContext.AFTER_UNDELETE) {

            this.afterUndelete();

        }

    }

    public Integer getLoopCount() {

        String handlerName = getHandlerName();

        if (!TriggerHandler.loopCountMap.containsKey(handlerName)) return 0;

        return TriggerHandler.loopCountMap.get(handlerName).count;

    }


    public void setMaxLoopCount(Integer max) {
        String handlerName = getHandlerName();
        if (!TriggerHandler.loopCountMap.containsKey(handlerName)) {
            TriggerHandler.loopCountMap.put(handlerName, new LoopCount(max));
        } else {
            TriggerHandler.loopCountMap.get(handlerName).setMax(max);
        }
    }

    public void clearMaxLoopCount() {
        this.setMaxLoopCount(-1);
    }


    //***************************************
    //* public static methods
    //***************************************/
    public static void bypass(String handlerName) {
        TriggerHandler.bypassedHandlers.add(handlerName);
    }

    public static void clearBypass(String handlerName) {
        TriggerHandler.bypassedHandlers.remove(handlerName);
    }

    public static Boolean isBypassed(String handlerName) {
        return TriggerHandler.bypassedHandlers.contains(handlerName);
    }

    public static void clearAllBypasses() {
        TriggerHandler.bypassedHandlers.clear();
    }

    @TestVisible
    private void setTriggerContext() {
        this.setTriggerContext(null, false);
    }


    @TestVisible
    private void setTriggerContext(String ctx, Boolean testMode) {
        
        this.isTriggerExecuting = true;

        if (!Trigger.isExecuting && !testMode) {
            this.isTriggerExecuting = false;
            return;
        }
        
        for (TriggerOperation operationType : TriggerOperation.values() ) {

            if ( isOperationTypeOrContextRunningOperationType ( operationType, ctx , OPERATION_TYPE_LABEL.get (operationType) ) ) {
                this.context = OPERATION_TYPE_CONTEXT.get(operationType);
                break;
            }

        }
    }

    private Boolean isOperationTypeOrContextRunningOperationType ( TriggerOperation operationType, String ctx , String operationTypeName ) {
        return  isOperationType (operationType) || isContextRunningOperationType(ctx, operationTypeName);
    }

    private Boolean isOperationType ( TriggerOperation operationType ) {
        return Trigger.isExecuting && Trigger.operationType == operationType;
    }

    private Boolean isContextRunningOperationType (String ctx , String operationType) {
        return ctx != null && ctx == operationType;
    }

    // increment the loop count
    @TestVisible
    private void addToLoopCount() {
        String handlerName = getHandlerName();

        if (TriggerHandler.loopCountMap.containsKey(handlerName)) {
            Boolean exceeded = TriggerHandler.loopCountMap.get(handlerName).increment();
            if (exceeded) {
                Integer max = TriggerHandler.loopCountMap.get(handlerName).max;
                throw new TriggerHandlerException('Maximum loop count of ' + String.valueOf(max) + ' reached in ' + handlerName);
            }
        }

    }

    // make sure this trigger should continue to run
    @TestVisible
    private Boolean validateRun() {

        if (!this.isTriggerExecuting || this.context == null) {
            throw new TriggerHandlerException('Trigger handler called outside of Trigger execution');
        }

        if (TriggerHandler.bypassedHandlers.contains(getHandlerName())) return false;

        return true;
    }

    @TestVisible
    private String getHandlerName() {
        return String.valueOf(this).substring(0, String.valueOf(this).indexOf(':'));
    }

    public Filter filtering() {
        return this.filter;
    }

    //***************************************
    //* context methods
    //***************************************/
    // context-specific methods for override
    @TestVisible
    protected virtual void beforeInsert() {        
    }
    
    @TestVisible
    protected virtual void beforeUpdate() {
    }

    @TestVisible
    protected virtual void beforeDelete() {
    }
    
    @TestVisible
    protected virtual void afterInsert() {
    }
    
    @TestVisible
    protected virtual void afterUpdate() {
    }
    
    @TestVisible
    protected virtual void afterDelete() {
    }
    
    @TestVisible
    protected virtual void afterUndelete() {
    }
    
    @TestVisible
    protected virtual void validateBeforeInsert() {
    }
    
    @TestVisible
    protected virtual void validateBeforeUpdate() {
    }

    // inner class for managing the loop count per handler
    @TestVisible
    private class LoopCount {

        private Integer max;
        private Integer count;

        public LoopCount() {
            this.max = 5;
            this.count = 0;
        }

        public LoopCount(Integer max) {
            this();
            this.max = max;
        }

        public Boolean increment() {
            this.count++;
            return this.exceeded();
        }

        public Boolean exceeded() {
            if (this.max < 0) return false;
            if (this.count > this.max) {
                return true;
            }
            return false;
        }
        public Integer getMax() {
            return this.max;
        }
        public Integer getCount() {
            return this.count;
        }
        public void setMax(Integer max) {
            this.max = max;
        }

    }

    // possible trigger contexts
    @TestVisible
    private enum TriggerContext {
        BEFORE_INSERT,
        BEFORE_UPDATE,
        BEFORE_DELETE,
        AFTER_INSERT,
        AFTER_UPDATE,
        AFTER_DELETE,
        AFTER_UNDELETE
    }

    // exception class
    public class TriggerHandlerException extends Exception {}
}