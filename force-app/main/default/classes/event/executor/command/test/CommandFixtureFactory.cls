@isTest
public class CommandFixtureFactory {

    public static Command newFakeCommand() {
        return new FakeCommand();
    }

    public class FakeCommand implements Command {

        public void callout (EventQueue event) {
            event.withStatus( EventQueueStatusType.SUCCESS);
        }

        public void executeUpdate (EventQueue event) {
            event.withStatus(EventQueueStatusType.SUCCESS);
        }

    }

    public virtual class MockedCommand implements Command {

        public Boolean calloutExecuted;
        public Boolean executeUpdateExecuted;

        virtual
        public void callout (EventQueue event) {
            calloutExecuted = true;
        }

        virtual
        public void executeUpdate (EventQueue event) {
            executeUpdateExecuted = true;
        }

    }

    public class MockedCalloutExceptionCommand extends MockedCommand {

        override
        public void callout (EventQueue event) {
            super.callout(event);

            if (true) {
                throw new CalloutException('Error');
            }
        }
        

    }

    public class MockedIntegrationBusinessExceptionCommand extends MockedCommand {

        override
        public void callout (EventQueue event) {
            super.callout(event);

            if (true) {
                throw new IntegrationBusinessException('Code', 'Message');
            }
        }        

    }

    public class MockedDmlExceptionCommand extends MockedCommand {

        override
        public void executeUpdate (EventQueue event) {
            
            super.executeUpdate(event);

            if (true) {
                throw new DmlException('Error Message');
            }
        }        

    }    
    
}