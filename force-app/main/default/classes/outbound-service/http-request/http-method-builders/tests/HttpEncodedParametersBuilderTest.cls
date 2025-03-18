@isTest
public class HttpEncodedParametersBuilderTest {

    @isTest
    public static void shouldInjectEncodedParameterInRequestPayloadBody () {
        
        HttpEncodedParametersBuilder builder = new HttpEncodedParametersBuilder();

        HttpRequest request = new HttpRequest();

        builder.injectPayload( new Map<String,String>{ 'parameter1' =>'value 1',
                                                       'parameter2' =>'value 2' }, request);

        Assert.areEqual( 'parameter2=value+2&parameter1=value+1&' , request.getBody());

    }

}