@isTest
public class AbstractOutboundCommandTest {

    public static String payloadResponse = '{"cep":"01001-000","logradouro":"Praça da Sé","complemento":"lado ímpar","unidade":"","bairro":"Sé","localidade":"São Paulo","uf":"SP","estado":"São Paulo","regiao":"Sudeste","ibge":"3550308","gia":"1004","ddd":"11","siafi":"7107"}';

    public static Map<String,String> expectedRequestPayload = new Map<String,String> {'zipcode' => '01001000' };


    public static GetAddressResponse newDefaultAddressResponse () {

        return fromJson (payloadResponse);

    }


    public static GetAddressResponse fromJson ( String payload ) {

        return (GetAddressResponse) JSON.deserialize(payload, GetAddressResponse.class);

    }



    @isTest
    static void shouldSetupEventAndCallout() {  

        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent', 'AbstractOutboundCommandTest.SuccessOutboundCommandMock');        

        AbstractOutboundCommand command = new SuccessOutboundCommandMock( JSON.serialize(expectedRequestPayload) 
                                                                        , fromJson(payloadResponse) );

        command.setup(event);

        Assert.areEqual(event, command.getEvent(), 'O evento deve ser configurado corretamente');
        Assert.isNotNull( command.getCallout(), 'O callout deve ser inicializado');        

    }

    @isTest
    static void shouldSendTransformedData() {

        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent', 'AbstractOutboundCommandTest.SuccessOutboundCommandMock');

        GetAddressResponse expectedResponse = fromJson(payloadResponse);

        AbstractOutboundCommand command = new SuccessOutboundCommandMock( JSON.serialize(expectedRequestPayload) 
                                                                        , expectedResponse );        
        command.callout(event);

        Assert.areEqual( expectedResponse , command.getResponse(), 'A resposta deve conter os dados transformados');
        
        command.executeUpdate();

        SuccessOutboundCommandMock executedCommand = (SuccessOutboundCommandMock) command;

        Assert.isTrue(executedCommand.executeUpdateExecuted , 'Deveria ter executado o executeUpdate');        

    }

    @isTest
    static void shouldThrowCalloutException () {

        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent', 'AbstractOutboundCommandTest.SuccessOutboundCommandMock');

        GetAddressResponse expectedResponse = fromJson(payloadResponse);

        AbstractOutboundCommand command = new CalloutExceptionOutboundCommandMock( JSON.serialize(expectedRequestPayload) 
                                                                        , expectedResponse );                
        try {
            
            command.callout(event);

            Assert.fail('exception expected');

        } catch (CalloutException e) {

            Assert.isTrue( e != null, 'exception expected');
            
        }
        
    }

    @isTest
    static void shouldRollbackTransactionWhenExecuteUpdateFailed () {

        EventQueue event = EventQueueFixtureFactory.newEvent('TestEvent', 'AbstractOutboundCommandTest.SuccessOutboundCommandMock');

        GetAddressResponse expectedResponse = fromJson(payloadResponse);

        AbstractOutboundCommand command = new ExecuteUpdateExceptionOutboundCommandMock( JSON.serialize(expectedRequestPayload) 
                                                                        , expectedResponse );                
        try {
            
            command.executeUpdate(event);

            Assert.fail('exception expected');

        } catch (DmlException e) {

            Assert.isTrue( e != null, 'exception expected');  
            
            event.withError(e);
            
        }

        EventQueueFixtureFactory.save( event.getSObject() );

        EventQueue__c storedEvent = [SELECT Id, Status__c FROM EventQueue__c LIMIT 1];

        Assert.areEqual( EventQueueStatusType.ERROR.name(), storedEvent.Status__c);

        List<Contact> contacts = [SELECT Id FROM Contact LIMIT 1];

        Assert.isTrue( contacts.isEmpty(), 'Expected Rollback all transaction when error occurred in executedUpdate' );
        
        
        
    }

    public abstract class BaseOutboundCommandMock extends AbstractOutboundCommand {

        public Object response;
              
        public BaseOutboundCommandMock(Object response) {
            super();
            this.response = response;
        }

        virtual
        override
        public void setup(EventQueue event) {
            super.setup(event);
            setCallout( new CalloutTest.CalloutMock (this.response, event));
        }

    }

    public virtual class SuccessOutboundCommandMock extends BaseOutboundCommandMock {

        String transformedPayload;

        public Boolean executeUpdateExecuted;

        public SuccessOutboundCommandMock(String transformedPayload, Object response) {
            super(response);            
            this.transformedPayload = transformedPayload;
            this.executeUpdateExecuted = false;
        }

        override
        public Object transform() {
            return JSON.deserialize(transformedPayload, Map<String,String>.class);
        }

        virtual
        override
        public void executeUpdate() {
            executeUpdateExecuted = true;
        }

    }

    public virtual class CalloutExceptionOutboundCommandMock extends SuccessOutboundCommandMock {


        Exception expectedException;

        public CalloutExceptionOutboundCommandMock(String transformedPayload
                                                , Object response) {
            this(transformedPayload, response, new CalloutException ('Unable to process request'));            
        }

        public CalloutExceptionOutboundCommandMock(String transformedPayload
                                                , Object response
                                                , Exception expectedException ) {
            super(transformedPayload, response);
            this.expectedException = expectedException;            
        }


        virtual
        override
        public void setup(EventQueue event) {
            super.setup(event);
            setCallout( new CalloutTest.CalloutExceptionMock (event, expectedException));
        }

    }

    public virtual class ExecuteUpdateExceptionOutboundCommandMock extends SuccessOutboundCommandMock {

        public ExecuteUpdateExceptionOutboundCommandMock(String transformedPayload
                                                        , Object response) {
            super(transformedPayload, response);            
        }

        override
        public void executeUpdate() {
            update new Contact();
        }

    }

    public class GetAddressResponse {
        public String cep;
        public String logradouro;
        public String complemento;
        public String unidade;
        public String bairro;
        public String localidade;
        public String uf;
        public String estado;
        public String regiao;
        public String ibge;
        public String gia;
        public String ddd;
        public String siafi;
    }

}
