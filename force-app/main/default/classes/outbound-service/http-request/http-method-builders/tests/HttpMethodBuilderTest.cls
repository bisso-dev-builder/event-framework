@isTest
public class HttpMethodBuilderTest {
    

    @isTest
    public static void shouldInjectRestPayloadBasedOnPostRequest () {


        HttpMethodBuilder builder = new HttpMethodBuilder();

        HttpRequest request = new HttpRequest();

        request.setMethod('POST');

        Map<String,String> payload = new Map<String,String>{ 'parameter1' =>'value 1',
                                                                'parameter2' =>'value 2' };

        builder.injectPayload( payload , request);

        Assert.areEqual( JSON.serialize(payload) , request.getBody());

        
    }

    @isTest
    public static void shouldInjectQueryStringPayloadBasedOnGetRequest () {


        HttpMethodBuilder builder = new HttpMethodBuilder();

        HttpRequest request = new HttpRequest();

        request.setMethod('GET');
        request.setEndpoint('https://api.com');

        Map<String,String> payload = new Map<String,String>{ 'parameter1' =>'value 1',
                                                                'parameter2' =>'value 2' };

        builder.injectPayload( payload , request);

        Assert.areEqual( 'https://api.com?parameter2=value+2&parameter1=value+1&' , request.getEndpoint());
        
    }




}