public virtual class EventUpdateExecutor extends AbstractEventExecutor {

    override
    public void execute (EventQueue event) {
       
        if ( event.isIgnored() || !event.hasHandler() ) {
            return;
        }

        execute(event.getCommand(), event);

    }

    override
    public void execute (Command command, EventQueue event) {

        try {           
            
            command.executeUpdate(event);

            if (!event.hasError()) {
                event.delivered();
            }

        } catch (IntegrationBusinessException e) {
            
            event.withError(e).disableRetry();

        } catch (DmlException e) {
            
            event.withError(e).disableRetry();
            
        } catch (Exception e) {

            event.withError(e).decreaseRetry();

        }

    }


}