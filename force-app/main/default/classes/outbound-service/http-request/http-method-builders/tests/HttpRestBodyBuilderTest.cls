@isTest
public class HttpRestBodyBuilderTest {

    @isTest
    public static void shouldInjectJsonPayloadDataInHttpRequest () {
        
        HttpRestBodyBuilder builder = new HttpRestBodyBuilder();

        HttpRequest request = new HttpRequest();

        builder.injectPayload( new Map<String,String>{ 'message' =>'value'}, request);

        Assert.areEqual( '{"message":"value"}' , request.getBody());

    }
}