public class EventCalloutExecutor extends AbstractEventExecutor implements Database.AllowsCallouts {   
    
    override
    public void execute (EventQueue event) {
       
        if ( !event.hasHandler() ) {
            event.unhandled();
            return;
        }

        if ( event.getConfig().isDisabled() ) {
            event.withStatus( EventQueueStatusType.IGNORED );
            return;
        }

        execute(event.getCommand(), event);

    }

    override
    public void execute (Command command, EventQueue event) {

        try {           
            
            command.callout(event);

            event.delivered();

        } catch (IntegrationBusinessException e) {
            
            event.withError(e).disableRetry();
            
        } catch (Exception e) {

            event.withError(e).decreaseRetry();

        }

    }    

}