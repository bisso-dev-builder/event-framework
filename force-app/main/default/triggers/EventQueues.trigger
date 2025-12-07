trigger EventQueues on EventQueue__c (before insert, before update
                            , after insert, after update
                            , before delete, after delete) {

    new EventQueueTriggerHandler().run();

}