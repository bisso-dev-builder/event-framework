@isTest
public class HttpPostBuilderTest {

    
    @isTest
    public static void shouldInjectPayloadWithJson () {
        
        HttpPostBuilder builder = new HttpPostBuilder();

        HttpRequest request = new HttpRequest();
        request.setMethod('POST');

        Map<String,String> payload = new Map<String,String>{ 'parameter1' =>'value 1',
                                                                'parameter2' =>'value 2' };

        builder.injectPayload( payload , request);

        Assert.areEqual( JSON.serialize(payload) , request.getBody());

        request.setHeader('Content-Type' ,'application/xyz');

        builder.injectPayload( payload , request);

        Assert.areEqual( JSON.serialize(payload) , request.getBody());

    }

    
    @isTest
    public static void shouldInjectEncodedParameterInRequestPayloadBody () {
        
        HttpPostBuilder builder = new HttpPostBuilder();

            HttpRequest request = new HttpRequest();
        request.setMethod('POST');
        request.setHeader('Content-Type' ,'application/x-www-form-urlencoded');

        builder.injectPayload( new Map<String,String>{ 'parameter1' =>'value 1',
                                                       'parameter2' =>'value 2' }, request);

        Assert.areEqual( 'parameter2=value+2&parameter1=value+1&' , request.getBody());

    }


}