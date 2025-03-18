@isTest
public class HttpRequestBuilderTest {
        
    @isTest
    public static void shouldCreateHttpRequest () {
        
        Map<String,String> payload = new Map<String,String>{ 'parameter1' =>'value 1',
                                                                'parameter2' =>'value 2' };

        Map<String,String> headers = new Map<String,String> { 'Content-Type' => 'application/json' };

        HttpRequestBuilder builder = new HttpRequestBuilder()
            .withEndPoint('https://api.com')
            .withHeaders(JSON.serialize(headers))
            .withMethod ('POST')
            .withTimeout( 10000 )
            .withCertificate (null)
            .withPayload( payload );

        Test.startTest();
        
        HttpRequest request = builder.build();        
        
        Test.stopTest();
        
        Assert.areEqual('https://api.com', request.getEndpoint() );
        Assert.areEqual('application/json', request.getHeader('Content-Type'));
        Assert.areEqual('POST', request.getMethod());
        Assert.areEqual( JSON.serialize(payload), request.getBody());
        
    }

}